module("modules.logic.sp01.odyssey.model.OdysseyTalentNodeMo", package.seeall)

local var_0_0 = pureTable("OdysseyTalentNodeMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.childNodes = {}
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.level = arg_2_1.level
	arg_2_0.consume = arg_2_1.consume
	arg_2_0.config = OdysseyConfig.instance:getTalentConfig(arg_2_0.id, arg_2_0.level)
end

function var_0_0.setChildNode(arg_3_0, arg_3_1)
	arg_3_0.childNodes[arg_3_1.id] = arg_3_1
end

function var_0_0.isHasChildNode(arg_4_0)
	return tabletool.len(arg_4_0.childNodes) > 0
end

function var_0_0.cleanChildNodes(arg_5_0)
	arg_5_0.childNodes = {}
end

return var_0_0
