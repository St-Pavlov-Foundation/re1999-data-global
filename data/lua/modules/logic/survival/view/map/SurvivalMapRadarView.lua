module("modules.logic.survival.view.map.SurvivalMapRadarView", package.seeall)

local var_0_0 = class("SurvivalMapRadarView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnRadar = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Radar/#btn_radar")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Radar/#go_tips")
	arg_1_0._animtips = gohelper.findChildAnim(arg_1_0.viewGO, "Radar/#go_tips")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Radar/#go_tips/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRadar:AddClickListener(arg_2_0._showHideTips, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapPlayerPosChange, arg_2_0._refreshRadarLevel, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapRadarPosChange, arg_2_0._refreshRadarLevel, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_2_0._onFollowTaskUpdate, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, arg_2_0._onUnitPosChange, arg_2_0)
	arg_2_0.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, arg_2_0._onSceneClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRadar:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapPlayerPosChange, arg_3_0._refreshRadarLevel, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapRadarPosChange, arg_3_0._refreshRadarLevel, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_3_0._onFollowTaskUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, arg_3_0._onUnitPosChange, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, arg_3_0._onSceneClick, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._levelGos = arg_4_0:getUserDataTb_()

	local var_4_0 = 1

	while true do
		local var_4_1 = gohelper.findChild(arg_4_0._btnRadar.gameObject, "#go_level" .. var_4_0)

		if var_4_1 then
			arg_4_0._levelGos[var_4_0] = var_4_1
		else
			break
		end

		var_4_0 = var_4_0 + 1
	end

	arg_4_0._isTipsClose = true

	gohelper.setActive(arg_4_0._gotips, true)

	arg_4_0._animtips.keepAnimatorControllerStateOnDisable = true

	arg_4_0._animtips:Play("close", 0, 1)
	arg_4_0:_refreshRadarLevel()
end

function var_0_0._onSceneClick(arg_5_0)
	if not arg_5_0._isTipsClose then
		arg_5_0:_showHideTips()
	end
end

function var_0_0._showHideTips(arg_6_0)
	if not arg_6_0._levelGo then
		return
	end

	arg_6_0._isTipsClose = not arg_6_0._isTipsClose

	SurvivalStatHelper.instance:statBtnClick("onClickRadar_" .. tostring(arg_6_0._isTipsClose), " SurvivalMapRadarView")
	arg_6_0._animtips:Play(arg_6_0._isTipsClose and "close" or "open")
end

function var_0_0._onFollowTaskUpdate(arg_7_0, arg_7_1)
	if arg_7_1.type == 1 then
		arg_7_0:_refreshRadarLevel()
	end
end

function var_0_0._onUnitPosChange(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = SurvivalMapModel.instance:getSceneMo()

	if arg_8_2.id == var_8_0.mainTask.followUnitUid then
		arg_8_0:_refreshRadarLevel()
	end
end

function var_0_0._refreshRadarLevel(arg_9_0)
	local var_9_0 = SurvivalMapModel.instance:getSceneMo()
	local var_9_1 = var_9_0.player.pos
	local var_9_2 = var_9_1
	local var_9_3 = SurvivalMapModel.instance:isInMiasma()

	if var_9_0.mainTask.followUnitUid ~= 0 and not var_9_3 then
		var_9_2 = var_9_0.sceneProp.radarPosition
	end

	local var_9_4 = SurvivalHelper.instance:getDistance(var_9_1, var_9_2)
	local var_9_5, var_9_6, var_9_7 = SurvivalHelper.instance:hexPointToWorldPoint(var_9_1.q, var_9_1.r)
	local var_9_8, var_9_9, var_9_10 = SurvivalHelper.instance:hexPointToWorldPoint(var_9_2.q, var_9_2.r)
	local var_9_11 = math.deg(math.atan2(var_9_10 - var_9_7, var_9_8 - var_9_5)) - 90
	local var_9_12 = 3
	local var_9_13

	while var_9_12 > 0 do
		local var_9_14 = SurvivalEnum.ConstId["RadarLv" .. var_9_12]
		local var_9_15, var_9_16 = SurvivalConfig.instance:getConstValue(var_9_14)
		local var_9_17

		var_9_17 = tonumber(var_9_15) or 0

		if var_9_17 <= var_9_4 then
			var_9_13 = var_9_16

			break
		end

		var_9_12 = var_9_12 - 1
	end

	if var_9_12 ~= arg_9_0._level then
		arg_9_0._level = var_9_12

		for iter_9_0, iter_9_1 in pairs(arg_9_0._levelGos) do
			gohelper.setActive(iter_9_1, iter_9_0 == var_9_12)
		end

		arg_9_0._levelGo = arg_9_0._levelGos[var_9_12]
	end

	if arg_9_0._levelGo then
		transformhelper.setLocalRotation(arg_9_0._levelGo.transform, 0, 0, var_9_11)

		arg_9_0._txtdesc.text = var_9_13
	else
		arg_9_0._isTipsClose = true

		arg_9_0._animtips:Play("close")
	end
end

return var_0_0
