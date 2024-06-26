package executils

import (
	"os/exec"
)

type Hooker interface {
	Before(Command) Command
	After(command *exec.Cmd)
}
