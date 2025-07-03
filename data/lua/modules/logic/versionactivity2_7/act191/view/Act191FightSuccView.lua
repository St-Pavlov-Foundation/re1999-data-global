module("modules.logic.versionactivity2_7.act191.view.Act191FightSuccView", package.seeall)

local var_0_0 = class("Act191FightSuccView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLeft = gohelper.findChild(arg_1_0.viewGO, "#go_Left")
	arg_1_0._simagecharacterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Left/#simage_characterbg")
	arg_1_0._goSpine = gohelper.findChild(arg_1_0.viewGO, "#go_Left/spineContainer/#go_Spine")
	arg_1_0._simagemaskImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Left/#simage_maskImage")
	arg_1_0._txtSayCn = gohelper.findChildText(arg_1_0.viewGO, "#go_Left/#txt_SayCn")
	arg_1_0._txtSayEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Left/SayEn/#txt_SayEn")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._goWin = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Win")
	arg_1_0._goFail = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Fail")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Reward")
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "#go_Right/Stage/#txt_Stage")
	arg_1_0._goPvp = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Stage/#go_Pvp")
	arg_1_0._goHeroItem = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Stage/#go_Pvp/role/layout/#go_HeroItem")
	arg_1_0._goPve = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Stage/#go_Pve")
	arg_1_0._gobossHpRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot")
	arg_1_0._gounlimited = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot/fight_act191bosshpview/Root/bossHp/Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "#go_Right/Level/mainTitle/TeamLvl/#image_Level")
	arg_1_0._btnData = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/#btn_Data")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._btnDataOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnData:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	if arg_4_0._uiSpine then
		arg_4_0._uiSpine:stopVoice()
	end

	arg_4_0:closeThis()
end

function var_0_0._btnDataOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = Activity191Model.instance:getCurActId()
	arg_6_0._uiSpine = GuiModelAgent.Create(arg_6_0._goSpine, true)

	arg_6_0._uiSpine:useRT()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actInfo = Activity191Model.instance:getActInfo()
	arg_7_0.gameInfo = arg_7_0.actInfo:getGameInfo()

	if arg_7_0.gameInfo.state == Activity191Enum.GameState.End then
		arg_7_0.curNode = arg_7_0.gameInfo.curNode
	else
		arg_7_0.curNode = arg_7_0.gameInfo.curNode - 1
	end

	arg_7_0.nodeInfo = arg_7_0.gameInfo:getNodeInfoById(arg_7_0.curNode)
	arg_7_0.isWin = arg_7_0.viewParam

	if arg_7_0.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(arg_7_0._goWin, arg_7_0.isWin)
	gohelper.setActive(arg_7_0._goFail, not arg_7_0.isWin)
	arg_7_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_7_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	arg_7_0.mySideMoList = FightDataHelper.entityMgr:getMyNormalList(nil, true)
	arg_7_0.enemyMoList = FightDataHelper.entityMgr:getEnemyNormalList(nil, true)
	arg_7_0._randomEntityMO = arg_7_0:_getRandomEntityMO()

	if arg_7_0.isWin and arg_7_0._randomEntityMO then
		arg_7_0:_setSpineVoice()
		gohelper.setActive(arg_7_0._goLeft, true)
		recthelper.setAnchorX(arg_7_0._goRight.transform, 0)
	else
		gohelper.setActive(arg_7_0._goLeft, false)
		recthelper.setAnchorX(arg_7_0._goRight.transform, -413)
	end

	arg_7_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_7_0._setCanPlayVoice, arg_7_0, 0.9)

	local var_7_0 = arg_7_0.gameInfo:getStageNodeInfoList(arg_7_0.nodeInfo.stage)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.nodeId == arg_7_0.curNode then
			local var_7_1 = lua_activity191_stage.configDict[arg_7_0.actId][iter_7_1.stage]

			arg_7_0._txtStage.text = string.format("<#FAB459>%s</color>-%d", var_7_1.name, iter_7_0)
		end
	end

	arg_7_0.nodeDetailMo = arg_7_0.gameInfo:getNodeDetailMo(arg_7_0.curNode)
	arg_7_0.isPvp = Activity191Helper.isPvpBattle(arg_7_0.nodeDetailMo.type)
	arg_7_0.isPve = Activity191Helper.isPveBattle(arg_7_0.nodeDetailMo.type)

	if arg_7_0.isPvp then
		local var_7_2 = lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpEpisodeName].value2
		local var_7_3 = GameUtil.setFirstStrSize(var_7_2, 70)
		local var_7_4 = lua_activity191_match_rank.configDict[arg_7_0.nodeDetailMo.matchInfo.rank].fightLevel

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageLevel, "act191_level_" .. string.lower(var_7_4))

		for iter_7_2, iter_7_3 in ipairs(arg_7_0.enemyMoList) do
			local var_7_5 = gohelper.cloneInPlace(arg_7_0._goHeroItem)
			local var_7_6 = gohelper.findChildSingleImage(var_7_5, "hero/simage_rolehead")

			if iter_7_3.entityType == FightEnum.EntityType.Monster then
				var_7_6:LoadImage(ResUrl.monsterHeadIcon(iter_7_3.skin))
			else
				var_7_6:LoadImage(ResUrl.getHeadIconSmall(iter_7_3.skin))
			end

			local var_7_7 = gohelper.findChild(var_7_5, "go_dead")

			gohelper.setActive(var_7_7, iter_7_3:isStatusDead())
		end

		gohelper.setActive(arg_7_0._goHeroItem, false)
	elseif arg_7_0.isPve or arg_7_0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		local var_7_8 = lua_activity191_fight_event.configDict[arg_7_0.nodeDetailMo.fightEventId]

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageLevel, "act191_level_" .. string.lower(var_7_8.fightLevel))

		local var_7_9 = arg_7_0:getResInst(Activity191Enum.PrefabPath.BossHpItem, arg_7_0._gobossHpRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_7_9, Act191BossHpItem)
	end

	arg_7_0:refreshReward()
	gohelper.setActive(arg_7_0._goPve, not arg_7_0.isPvp)
	gohelper.setActive(arg_7_0._goPvp, arg_7_0.isPvp)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._canPlayVoice = false

	gohelper.setActive(arg_8_0._goSpine, false)
	FightController.onResultViewClose()
	Act191StatController.instance:statGameTime(arg_8_0.viewName)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._setCanPlayVoice, arg_9_0)
end

function var_0_0._getRandomEntityMO(arg_10_0)
	local var_10_0 = arg_10_0.mySideMoList

	for iter_10_0 = #var_10_0, 1, -1 do
		local var_10_1 = var_10_0[iter_10_0]

		if not arg_10_0:_getSkin(var_10_1) then
			table.remove(var_10_0, iter_10_0)
		end
	end

	local var_10_2 = {}

	tabletool.addValues(var_10_2, var_10_0)

	for iter_10_1 = #var_10_2, 1, -1 do
		local var_10_3 = var_10_0[iter_10_1]
		local var_10_4 = FightAudioMgr.instance:_getHeroVoiceCOs(var_10_3.modelId, CharacterEnum.VoiceType.FightResult)

		if var_10_4 and #var_10_4 > 0 then
			if var_10_3:isMonster() then
				table.remove(var_10_2, iter_10_1)
			end
		else
			table.remove(var_10_2, iter_10_1)
		end
	end

	if #var_10_2 > 0 then
		return var_10_2[math.random(#var_10_2)]
	elseif #var_10_0 > 0 then
		return var_10_0[math.random(#var_10_0)]
	end
end

function var_0_0._setCanPlayVoice(arg_11_0)
	arg_11_0._canPlayVoice = true

	arg_11_0:_playSpineVoice()
end

function var_0_0._setSpineVoice(arg_12_0)
	local var_12_0 = arg_12_0:_getSkin(arg_12_0._randomEntityMO)

	if var_12_0 then
		arg_12_0._spineLoaded = false

		arg_12_0._uiSpine:setImgPos(0)
		arg_12_0._uiSpine:setResPath(var_12_0, function()
			arg_12_0._spineLoaded = true

			arg_12_0._uiSpine:setUIMask(true)
			arg_12_0:_playSpineVoice()
			arg_12_0._uiSpine:setAllLayer(UnityLayer.UI)
		end, arg_12_0)

		local var_12_1, var_12_2 = SkinConfig.instance:getSkinOffset(var_12_0.fightSuccViewOffset)

		if var_12_2 then
			var_12_1, _ = SkinConfig.instance:getSkinOffset(var_12_0.characterViewOffset)
			var_12_1 = SkinConfig.instance:getAfterRelativeOffset(504, var_12_1)
		end

		local var_12_3 = tonumber(var_12_1[3])
		local var_12_4 = tonumber(var_12_1[1])
		local var_12_5 = tonumber(var_12_1[2])

		recthelper.setAnchor(arg_12_0._goSpine.transform, var_12_4, var_12_5)
		transformhelper.setLocalScale(arg_12_0._goSpine.transform, var_12_3, var_12_3, var_12_3)
	else
		gohelper.setActive(arg_12_0._goSpine, false)
	end
end

function var_0_0._playSpineVoice(arg_14_0)
	if not arg_14_0._canPlayVoice then
		return
	end

	if not arg_14_0._spineLoaded then
		return
	end

	local var_14_0 = FightAudioMgr.instance:_getHeroVoiceCOs(arg_14_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, arg_14_0._randomEntityMO.skin)

	if var_14_0 and #var_14_0 > 0 then
		local var_14_1 = var_14_0[1]

		arg_14_0._uiSpine:playVoice(var_14_1, nil, arg_14_0._txtSayCn, arg_14_0._txtSayEn)
	end
end

function var_0_0._getSkin(arg_15_0, arg_15_1)
	local var_15_0 = FightConfig.instance:getSkinCO(arg_15_1.skin)
	local var_15_1 = var_15_0 and not string.nilorempty(var_15_0.verticalDrawing)
	local var_15_2 = var_15_0 and not string.nilorempty(var_15_0.live2d)

	if var_15_1 or var_15_2 then
		return var_15_0
	end
end

function var_0_0.refreshReward(arg_16_0)
	local var_16_0 = {}

	if arg_16_0.isPvp then
		if arg_16_0.isWin then
			local var_16_1 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].auto and "autoRewardView" or "rewardView"
			local var_16_2 = Activity191Enum.NodeType2Key[arg_16_0.nodeDetailMo.type]
			local var_16_3 = lua_activity191_pvp_match.configDict[var_16_2]
			local var_16_4 = GameUtil.splitString2(var_16_3[var_16_1], true)

			for iter_16_0, iter_16_1 in ipairs(var_16_4) do
				if not var_16_0[iter_16_1[1]] then
					var_16_0[iter_16_1[1]] = iter_16_1[2]
				else
					var_16_0[iter_16_1[1]] = var_16_0[iter_16_1[1]] + iter_16_1[2]
				end
			end
		end
	else
		local var_16_5 = arg_16_0.actInfo.triggerEffectPushList

		for iter_16_2, iter_16_3 in ipairs(var_16_5) do
			for iter_16_4, iter_16_5 in ipairs(iter_16_3.effectId) do
				local var_16_6 = lua_activity191_effect.configDict[iter_16_5]

				if not string.nilorempty(var_16_6.itemParam) then
					local var_16_7 = GameUtil.splitString2(var_16_6.itemParam, true)

					for iter_16_6, iter_16_7 in ipairs(var_16_7) do
						if not var_16_0[iter_16_7[1]] then
							var_16_0[iter_16_7[1]] = iter_16_7[2]
						else
							var_16_0[iter_16_7[1]] = var_16_0[iter_16_7[1]] + iter_16_7[2]
						end
					end
				end
			end
		end
	end

	for iter_16_8, iter_16_9 in pairs(var_16_0) do
		local var_16_8 = arg_16_0:getResInst(Activity191Enum.PrefabPath.RewardItem, arg_16_0._goReward)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_16_8, Act191RewardItem):setData(iter_16_8, iter_16_9)
	end

	gohelper.setActive(arg_16_0._goReward, tabletool.len(var_16_0) ~= 0)
end

return var_0_0
