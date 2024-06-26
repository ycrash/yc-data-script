package capture

import (
	"fmt"
	"os"

	"yc-agent/internal/capture/executils"
)

type Custom struct {
	Capture
	Index     int
	UrlParams string
	Command   []string
}

func (c *Custom) Run() (result Result, err error) {
	custom, err := os.Create(fmt.Sprintf("custom%d.out", c.Index))
	if err != nil {
		return
	}
	defer custom.Close()
	c.Cmd, err = executils.CommandStartInBackgroundToWriter(custom, c.Command)
	if err != nil {
		return
	}
	if c.Cmd.IsSkipped() {
		result.Msg = "skipped capturing custom"
		result.Ok = false
		return
	}
	c.Cmd.Wait()
	result.Msg, result.Ok = PostCustomData(c.Endpoint(), c.UrlParams, custom)
	return
}
