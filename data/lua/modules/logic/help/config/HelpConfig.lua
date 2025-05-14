module("modules.logic.help.config.HelpConfig", package.seeall)

local var_0_0 = class("HelpConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._helpConfig = nil
	arg_1_0._pageConfig = nil
	arg_1_0._helpPageTabConfig = nil
	arg_1_0._helpVideoConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"viewhelp",
		"helppage",
		"help_page_tab",
		"help_video"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "viewhelp" then
		arg_3_0._helpConfig = arg_3_2
	elseif arg_3_1 == "helppage" then
		arg_3_0._pageConfig = arg_3_2
	elseif arg_3_1 == "help_page_tab" then
		arg_3_0._helpPageTabConfig = arg_3_2
	elseif arg_3_1 == "help_video" then
		arg_3_0._helpVideoConfig = arg_3_2
	end
end

function var_0_0.getHelpCO(arg_4_0, arg_4_1)
	return arg_4_0._helpConfig.configDict[arg_4_1]
end

function var_0_0.getHelpPageCo(arg_5_0, arg_5_1)
	return arg_5_0._pageConfig.configDict[arg_5_1]
end

function var_0_0.getHelpPageTabList(arg_6_0)
	return arg_6_0._helpPageTabConfig.configList
end

function var_0_0.getHelpPageTabCO(arg_7_0, arg_7_1)
	return arg_7_0._helpPageTabConfig.configDict[arg_7_1]
end

function var_0_0.getHelpVideoCO(arg_8_0, arg_8_1)
	return arg_8_0._helpVideoConfig.configDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
