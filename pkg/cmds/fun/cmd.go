package fun

import (
	"github.com/rwxrob/bonzai"
	"github.com/rwxrob/bonzai/comp"
	"github.com/rwxrob/code-mage-book/pkg/cmds/fun/rayfish"
	"github.com/rwxrob/code-mage-book/pkg/cmds/fun/sunrise"
)

var Cmd = &bonzai.Cmd{
	Name: `fun`,
	Cmds: []*bonzai.Cmd{sunrise.Cmd, rayfish.Cmd},
	Comp: comp.Cmds,
}
