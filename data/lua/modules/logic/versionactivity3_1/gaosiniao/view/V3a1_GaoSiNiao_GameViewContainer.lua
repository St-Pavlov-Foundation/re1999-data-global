module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameViewContainer", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameViewContainer", Activity210CorvusViewBaseContainer)
local var_0_1 = 1

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V3a1_GaoSiNiao_GameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0._navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0._navigateView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V3a1_GaoSiNiao_GameView_Exit, MsgBoxEnum.BoxType.Yes_No, arg_3_0._endYesCallback, nil, nil, arg_3_0, nil, nil)
end

function var_0_0._endYesCallback(arg_4_0)
	if arg_4_0:isSP() then
		arg_4_0:completeGame(nil, arg_4_0.closeThis, arg_4_0)
	else
		arg_4_0:track_exit()
		arg_4_0:closeThis()
	end
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0:_recoverBadPrefsData()
end

function var_0_0._recoverBadPrefsData(arg_6_0)
	local var_6_0 = arg_6_0:episodeId()
	local var_6_1, var_6_2 = arg_6_0:getEpisodeCOList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_3 = iter_6_1.episodeId
		local var_6_4 = arg_6_0:isEpisodeOpen(var_6_3)
		local var_6_5 = arg_6_0:hasPassLevelAndStory(var_6_3)
		local var_6_6 = arg_6_0:guideId(var_6_3)

		if var_6_5 then
			arg_6_0:directFinishGuide(var_6_6)
			arg_6_0:saveHasPlayedGuide(var_6_3)
		elseif arg_6_0:hasPlayedGuide(var_6_3) and not var_6_4 then
			arg_6_0:unsaveHasPlayedGuide(var_6_3)
			GuideStepController.instance:clearFlow()
		end

		if arg_6_0:isGuideRunning(var_6_6) then
			GuideStepController.instance:clearFlow(var_6_6)
		end

		if var_6_3 ~= var_6_0 then
			GuideStepController.instance:clearFlow(var_6_6)
		end
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		local var_6_7 = iter_6_3.episodeId
		local var_6_8 = arg_6_0:isEpisodeOpen(var_6_7)
		local var_6_9 = arg_6_0:hasPassLevelAndStory(var_6_7)
		local var_6_10 = arg_6_0:guideId(var_6_7)

		if var_6_9 then
			arg_6_0:directFinishGuide(var_6_10)
			arg_6_0:saveHasPlayedGuide(var_6_7)
		elseif arg_6_0:hasPlayedGuide(var_6_7) and not var_6_8 then
			arg_6_0:unsaveHasPlayedGuide(var_6_7)
			GuideStepController.instance:clearFlow(var_6_10)
		end

		if arg_6_0:isGuideRunning(var_6_10) then
			GuideStepController.instance:clearFlow(var_6_10)
		end

		if var_6_7 ~= var_6_0 then
			GuideStepController.instance:clearFlow(var_6_10)
		end
	end
end

function var_0_0.onContainerDestroy(arg_7_0)
	arg_7_0:dragContext():clear()
end

function var_0_0.isSP(arg_8_0)
	return GaoSiNiaoConfig.instance:isSP(arg_8_0:episodeId())
end

function var_0_0.episodeId(arg_9_0)
	return GaoSiNiaoBattleModel.instance:episodeId()
end

function var_0_0.mapMO(arg_10_0)
	return GaoSiNiaoBattleModel.instance:mapMO()
end

function var_0_0.dragContext(arg_11_0)
	return GaoSiNiaoBattleModel.instance:dragContext()
end

function var_0_0.trackMO(arg_12_0)
	return GaoSiNiaoBattleModel.instance:trackMO()
end

function var_0_0.restart(arg_13_0)
	GaoSiNiaoBattleModel.instance:restart(arg_13_0:episodeId())
end

function var_0_0.completeGame(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	GaoSiNiaoController.instance:completeGame(arg_14_0:episodeId(), arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:track_finish()
end

function var_0_0.exitGame(arg_15_0)
	GaoSiNiaoController.instance:exitGame(arg_15_0:episodeId())
end

function var_0_0.bagDataList(arg_16_0)
	return arg_16_0:mapMO():bagList()
end

function var_0_0.gridDataList(arg_17_0)
	return arg_17_0:mapMO():gridDataList()
end

function var_0_0.mapSize(arg_18_0)
	return arg_18_0:mapMO():mapSize()
end

function var_0_0.rowCol(arg_19_0)
	return arg_19_0:mapMO():rowCol()
end

function var_0_0.setLocalRotZ(arg_20_0, arg_20_1, arg_20_2)
	transformhelper.setLocalRotation(arg_20_1, 0, 0, arg_20_2)
end

function var_0_0.setSprite(arg_21_0, arg_21_1, arg_21_2)
	UISpriteSetMgr.instance:setV3a1GaoSiNiaoSprite(arg_21_1, arg_21_2)

	arg_21_1.enabled = true
end

function var_0_0.setSpriteByPathType(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 == GaoSiNiaoEnum.PathType.None then
		arg_22_1.enabled = false

		return
	end

	local var_22_0 = GaoSiNiaoEnum.PathInfo[arg_22_2]

	arg_22_0:setSprite(arg_22_1, GaoSiNiaoConfig.instance:getPathSpriteName(var_22_0.spriteId))
	arg_22_0:setLocalRotZ(arg_22_1.transform, var_22_0.zRot)
end

function var_0_0.setBloodByPathType(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 == GaoSiNiaoEnum.PathType.None then
		arg_23_1.enabled = false

		return
	end

	local var_23_0 = GaoSiNiaoEnum.PathInfo[arg_23_2]

	arg_23_0:setSprite(arg_23_1, GaoSiNiaoConfig.instance:getBloodSpriteName(var_23_0.spriteId))
	arg_23_0:setLocalRotZ(arg_23_1.transform, var_23_0.zRot)
end

function var_0_0.setSpriteByGridType(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 == GaoSiNiaoEnum.GridType.Empty then
		arg_24_1.enabled = false

		return
	end

	arg_24_0:setSprite(arg_24_1, GaoSiNiaoConfig.instance:getGridSpriteName(arg_24_2))
	arg_24_0:setLocalRotZ(arg_24_1.transform, arg_24_3.zRot)
end

function var_0_0.guideId(arg_25_0, arg_25_1)
	arg_25_1 = arg_25_1 or arg_25_0:episodeId()

	return GaoSiNiaoConfig.instance:getEpisodeCO_guideId(arg_25_1)
end

function var_0_0.isGuideRunning(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or arg_26_0:guideId()

	return GuideModel.instance:isGuideRunning(arg_26_1)
end

function var_0_0._prefKey_HasPlayedGuide(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or arg_27_0:episodeId()

	return arg_27_0:getPrefsKeyPrefix_episodeId(arg_27_1) .. "HasPlayedGuide"
end

function var_0_0.saveHasPlayedGuide(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:_prefKey_HasPlayedGuide(arg_28_1)

	arg_28_0:saveInt(var_28_0, 1)
end

function var_0_0.unsaveHasPlayedGuide(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_prefKey_HasPlayedGuide(arg_29_1)

	arg_29_0:saveInt(var_29_0, 0)
end

function var_0_0.hasPlayedGuide(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:_prefKey_HasPlayedGuide(arg_30_1)

	return arg_30_0:getInt(var_30_0, 0) == 1
end

function var_0_0.directFinishGuide(arg_31_0, arg_31_1)
	local var_31_0 = GuideModel.instance:getById(arg_31_1)

	if not var_31_0 then
		return
	end

	GuideStepController.instance:clearFlow(arg_31_1)

	local var_31_1 = GuideConfig.instance:getStepList(arg_31_1)
	local var_31_2 = math.max(1, var_31_0.currStepId or 1)

	for iter_31_0 = #var_31_1, var_31_2, -1 do
		local var_31_3 = var_31_1[iter_31_0]
		local var_31_4 = var_31_3.stepId

		if var_31_3.keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(arg_31_1, var_31_4)

			break
		else
			GuideModel.instance:clientFinishStep(arg_31_1, var_31_4)
		end
	end
end

function var_0_0.track_reset(arg_32_0)
	arg_32_0:trackMO():onGameReset()
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.reset)
end

function var_0_0.track_finish(arg_33_0)
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.finish)
end

function var_0_0.track_exit(arg_34_0)
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.exit)
end

return var_0_0
