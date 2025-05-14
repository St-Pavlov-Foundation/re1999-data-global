module("modules.logic.versionactivity2_4.pinball.controller.PinballController", package.seeall)

local var_0_0 = class("PinballController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._getInfo, arg_1_0)
	arg_1_0:registerCallback(PinballEvent.GuideAddRes, arg_1_0._guideAddRes, arg_1_0)
end

function var_0_0._getInfo(arg_2_0, arg_2_1)
	if arg_2_1 and arg_2_1 ~= VersionActivity2_4Enum.ActivityId.Pinball then
		return
	end

	if PinballModel.instance:isOpen() then
		Activity178Rpc.instance:sendGetAct178Info(VersionActivity2_4Enum.ActivityId.Pinball)
	end
end

function var_0_0.openMainView(arg_3_0)
	ViewMgr.instance:openView(ViewName.PinballCityView)
end

function var_0_0.sendGuideMainLv(arg_4_0)
	arg_4_0:dispatchEvent(PinballEvent.GuideMainLv, var_0_0._checkMainLv)
end

function var_0_0._checkMainLv(arg_5_0)
	local var_5_0 = tonumber(arg_5_0)

	if not var_5_0 then
		return
	end

	return var_5_0 <= PinballModel.instance:getScoreLevel()
end

function var_0_0._guideAddRes(arg_6_0)
	Activity178Rpc.instance:sendAct178GuideAddGrain(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0.removeBuilding(arg_7_0, arg_7_1)
	local var_7_0 = PinballModel.instance:getBuildingInfo(arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = {}

	GameUtil.setDefaultValue(var_7_1, 0)

	for iter_7_0 = 1, var_7_0.level do
		local var_7_2 = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_7_0.configId][iter_7_0]

		if var_7_2 and not string.nilorempty(var_7_2.cost) then
			local var_7_3 = GameUtil.splitString2(var_7_2.cost, true)

			for iter_7_1, iter_7_2 in pairs(var_7_3) do
				var_7_1[iter_7_2[1]] = var_7_1[iter_7_2[1]] + iter_7_2[2]
			end
		end
	end

	local var_7_4 = {}

	for iter_7_3, iter_7_4 in pairs(var_7_1) do
		local var_7_5 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][iter_7_3]

		if var_7_5 then
			table.insert(var_7_4, GameUtil.getSubPlaceholderLuaLang(luaLang("PinballController_removeBuilding"), {
				var_7_5.name,
				iter_7_4
			}))
		end
	end

	arg_7_0._tempIndex = arg_7_1

	GameFacade.showMessageBox(MessageBoxIdDefine.PinballRemoveBuilding, MsgBoxEnum.BoxType.Yes_No, arg_7_0._realRemoveBuilding, nil, nil, arg_7_0, nil, nil, table.concat(var_7_4, luaLang("PinballController_sep")))
end

function var_0_0._realRemoveBuilding(arg_8_0)
	local var_8_0 = PinballModel.instance:getBuildingInfo(arg_8_0._tempIndex)

	if not var_8_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, var_8_0.configId, PinballEnum.BuildingOperType.Remove, arg_8_0._tempIndex)
end

var_0_0.instance = var_0_0.New()

return var_0_0
