module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupModel", package.seeall)

local var_0_0 = class("OdysseyHeroGroupModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._formInfoList = {}
	arg_2_0._formInfoDic = {}
	arg_2_0._heroGroupInfoDic = {}
	arg_2_0._curIndex = 1
end

function var_0_0.isPositionOpen(arg_3_0, arg_3_1)
	return arg_3_1 > 0 and arg_3_1 <= OdysseyEnum.MaxHeroGroupCount
end

function var_0_0.updateFormInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._formInfoDic
	local var_4_1 = arg_4_0._heroGroupInfoDic

	if arg_4_1 ~= nil then
		local var_4_2 = arg_4_1.no
		local var_4_3

		if var_4_0[var_4_2] == nil then
			var_4_0[var_4_2] = arg_4_1

			local var_4_4 = OdysseyHeroGroupMo.New()

			var_4_4:init(arg_4_1)

			var_4_1[arg_4_1.no] = var_4_4
		else
			var_4_0[var_4_2] = arg_4_1

			var_4_1[var_4_2]:init(arg_4_1)
		end

		logNormal("奥德赛阵营 服务器返回 当前索引:" .. tostring(arg_4_1.no))

		arg_4_0._curIndex = arg_4_1.no
	end

	tabletool.clear(arg_4_0._formInfoList)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		table.insert(arg_4_0._formInfoList, iter_4_1)
	end

	OdysseyHeroGroupController.instance:dispatchEvent(OdysseyEvent.OnHeroGroupUpdate)
end

function var_0_0.getCurHeroGroup(arg_5_0)
	return arg_5_0._heroGroupInfoDic[arg_5_0._curIndex]
end

function var_0_0.getSaveType(arg_6_0)
	return arg_6_0._saveType
end

function var_0_0.setSaveType(arg_7_0, arg_7_1)
	arg_7_0._saveType = arg_7_1
end

function var_0_0.getCommonGroupName(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or arg_8_0._curIndex

	return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_8_1))
end

function var_0_0.canSwitchHeroGroupSelectIndex(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		logError("无法切到玩法编队")

		return false
	end

	if arg_9_0._curIndex == arg_9_1 then
		return false
	end

	logNormal("奥德赛阵营 本地设置 当前索引:" .. tostring(arg_9_1))

	return true
end

function var_0_0.getCurFormInfo(arg_10_0)
	return arg_10_0._formInfoDic[arg_10_0._curIndex]
end

function var_0_0.getCurIndex(arg_11_0)
	return arg_11_0._curIndex
end

function var_0_0.getHeroGroupByIndex(arg_12_0, arg_12_1)
	return arg_12_0._heroGroupInfoDic[arg_12_1]
end

function var_0_0.getFormByNoId(arg_13_0, arg_13_1)
	return arg_13_0._formInfoDic[arg_13_1]
end

function var_0_0.getBattleRoleNum(arg_14_0)
	return OdysseyEnum.MaxHeroGroupCount
end

var_0_0.instance = var_0_0.New()

return var_0_0
