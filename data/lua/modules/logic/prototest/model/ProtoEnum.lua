module("modules.logic.prototest.model.ProtoEnum", package.seeall)

local var_0_0 = _M

var_0_0.OnClickModifyItem = 1
var_0_0.OnClickReqListItem = 2
var_0_0.LabelType = {
	"optional",
	"required",
	"repeated",
	repeated = 3,
	optional = 1,
	required = 2
}
var_0_0.ParamType = {
	nil,
	nil,
	"int64",
	"uint64",
	"int32",
	nil,
	nil,
	"bool",
	"string",
	nil,
	"proto",
	nil,
	"uint32",
	bool = 8,
	proto = 11,
	int32 = 5,
	uint32 = 13,
	string = 9,
	int64 = 3,
	uint64 = 4
}
var_0_0.DefaultValue = {
	bool = {
		"true",
		"false"
	},
	int32 = {
		"0",
		"-1",
		"1",
		"2147483647",
		"-2147483648"
	},
	uint32 = {
		"0",
		"-1",
		"1",
		"4294967295",
		"2147483647",
		"-2147483648"
	},
	int64 = {
		"0",
		"-1",
		"1",
		"9223372036854775807",
		"-9223372036854775808"
	},
	uint64 = {
		"0",
		"-1",
		"1",
		"18446744073709551615",
		"9223372036854775807",
		"-9223372036854775808"
	},
	string = {
		""
	}
}
var_0_0.IgnoreCmdList = {
	[19233] = true,
	[24032] = true,
	[-16648] = true
}

return var_0_0
