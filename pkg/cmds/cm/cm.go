package cm

import (
	"github.com/rwxrob/bonzai"
	"github.com/rwxrob/bonzai/cmds/help"
	"github.com/rwxrob/bonzai/comp"
	"github.com/rwxrob/code-mage-book/pkg/cmds/fun"
)

var Cmd = &bonzai.Cmd{
	Name:  `cm`,
	Alias: `code-mage`,
	Cmds:  []*bonzai.Cmd{help.Cmd, fun.Cmd},
	Comp:  comp.Cmds,
}
