module("modules.logic.versionactivity2_4.pinball.view.PinballBuildItem", package.seeall)

local var_0_0 = class("PinballBuildItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_1, "#image_icon")
	arg_1_0._godone = gohelper.findChild(arg_1_1, "#go_done")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "#txt_name")
end

function var_0_0.initData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._data = arg_2_1
	arg_2_0._index = arg_2_2
	arg_2_0._txtname.text = arg_2_0._data.name

	gohelper.setActive(arg_2_0._golock, arg_2_0:isLock())
	gohelper.setActive(arg_2_0._godone, arg_2_0:isDone())
end

function var_0_0.isDone(arg_3_0)
	if PinballModel.instance:getBuildingNum(arg_3_0._data.id) >= arg_3_0._data.limit then
		return true
	end

	return false
end

function var_0_0.isLock(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._data.condition

	if string.nilorempty(var_4_0) then
		return false
	end

	local var_4_1 = GameUtil.splitString2(var_4_0, true)

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		local var_4_2 = iter_4_1[1]

		if var_4_2 == PinballEnum.ConditionType.Talent then
			local var_4_3 = iter_4_1[2]

			if not PinballModel.instance:getTalentMo(var_4_3) then
				if arg_4_1 then
					local var_4_4 = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_4_3]

					GameFacade.showToast(ToastEnum.Act178TalentCondition, var_4_4.name)
				end

				return true
			end
		elseif var_4_2 == PinballEnum.ConditionType.Score then
			local var_4_5 = iter_4_1[2]

			if var_4_5 > PinballModel.instance.maxProsperity then
				if arg_4_1 then
					local var_4_6 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_4_5)

					GameFacade.showToast(ToastEnum.Act178ScoreCondition, var_4_6)
				end

				return true
			end
		end
	end

	return false
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselect, arg_5_1)

	local var_5_0 = arg_5_0:isDone()
	local var_5_1 = 1

	if not var_5_0 and not arg_5_1 then
		var_5_1 = 1
	elseif var_5_0 and not arg_5_1 then
		var_5_1 = 2
	elseif var_5_0 and arg_5_1 then
		var_5_1 = 3
	elseif not var_5_0 and arg_5_1 then
		var_5_1 = 4
	end

	local var_5_2 = arg_5_0._data.icon

	arg_5_0._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s_%s.png", var_5_2, var_5_1))
end

return var_0_0
