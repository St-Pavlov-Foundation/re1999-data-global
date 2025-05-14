module("modules.logic.notice.model.NoticeType", package.seeall)

local var_0_0 = _M

var_0_0.All = 0
var_0_0.Activity = 1
var_0_0.Game = 2
var_0_0.System = 3
var_0_0.Playing = 4
var_0_0.BeforeLogin = 5
var_0_0.Information = 6
var_0_0.NoticeList = {
	var_0_0.Activity,
	var_0_0.Game,
	var_0_0.System,
	var_0_0.Information
}

function var_0_0.getTypeIndex(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(var_0_0.NoticeList) do
		if arg_1_0 == iter_1_1 then
			return iter_1_0
		end
	end

	return 1
end

return var_0_0
