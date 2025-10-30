module("modules.logic.season.view3_0.Season3_0HeroGroupFightView", package.seeall)

local var_0_0 = class("Season3_0HeroGroupFightView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._goreplayready = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_replayready")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	arg_1_0._btnrestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	arg_1_0._gobtncontain = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain")
	arg_1_0._btncloth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/btnCloth")
	arg_1_0._txtclothname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	arg_1_0._txtclothnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	arg_1_0._btnstartseason = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	arg_1_0._btnseasonreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	arg_1_0._imagereplaybg = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	arg_1_0._imagereplayicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	arg_1_0._txtreplaycount = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	arg_1_0._dropseasonherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	arg_1_0._dropherogrouparrow = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup/arrow").transform
	arg_1_0._goherogroupcontain = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")
	arg_1_0._gosupercard = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0._gosupercard, "#simage_role")
	arg_1_0._gosupercardlight = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/light")
	arg_1_0._gosupercardempty = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#go_supercardempty")
	arg_1_0._gosupercardpos = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#go_supercardpos")
	arg_1_0._btnsupercardclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#btn_supercardclick")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_mask")
	arg_1_0._goTrialTips = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips")
	arg_1_0._goTrialTipsBg = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg")
	arg_1_0._goTrialTipsItem = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg/#go_tipsitem")
	arg_1_0._btnTrialTips = gohelper.findChildButton(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#btn_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTrialTips:AddClickListener(arg_2_0._switchTrialTips, arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClock, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnrecommendOnClick, arg_2_0)
	arg_2_0._btnrestrain:AddClickListener(arg_2_0._btnrestrainOnClick, arg_2_0)
	arg_2_0._btnstartseason:AddClickListener(arg_2_0._btnstartseasonOnClick, arg_2_0)
	arg_2_0._btnseasonreplay:AddClickListener(arg_2_0._btnseasonreplayOnClick, arg_2_0)
	arg_2_0._btnsupercardclick:AddClickListener(arg_2_0._btnseasonsupercardOnClick, arg_2_0)
	arg_2_0._dropseasonherogroup:AddOnValueChanged(arg_2_0._groupDropValueChanged, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0._onTouch, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_3_0._onTouch, arg_3_0)
	arg_3_0._btnTrialTips:RemoveClickListener()
	arg_3_0._btncloth:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
	arg_3_0._btnrestrain:RemoveClickListener()
	arg_3_0._btnstartseason:RemoveClickListener()
	arg_3_0._btnseasonreplay:RemoveClickListener()
	arg_3_0._btnsupercardclick:RemoveClickListener()
	arg_3_0._dropseasonherogroup:RemoveOnValueChanged()
end

function var_0_0._setTrialNumTips(arg_4_0)
	local var_4_0, var_4_1 = var_0_0._getEpisodeConfigAndBattleConfig()
	local var_4_2 = {}

	if var_4_1 and var_4_1.trialLimit > 0 then
		if var_4_1.trialLimit >= 4 then
			var_4_2[1] = luaLang("herogroup_trial_tip")
		else
			var_4_2[1] = formatLuaLang("herogroup_trial_limit_tip", var_4_1.trialLimit)
		end
	end

	if var_4_1 and not string.nilorempty(var_4_1.trialEquips) then
		table.insert(var_4_2, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(arg_4_0._goTrialTips, #var_4_2 > 0)

	if #var_4_2 > 0 then
		gohelper.CreateObjList(arg_4_0, arg_4_0._setTrialTipsTxt, var_4_2, arg_4_0._goTrialTipsBg, arg_4_0._goTrialTipsItem)
	end
end

function var_0_0._onTouch(arg_5_0)
	if arg_5_0._goTrialTips.activeSelf and arg_5_0._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(arg_5_0._goTrialTipsBg, false)
	end
end

function var_0_0._setTrialTipsTxt(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	gohelper.findChildTextMesh(arg_6_1, "desc").text = arg_6_2
end

function var_0_0._switchTrialTips(arg_7_0)
	gohelper.setActive(arg_7_0._goTrialTipsBg, not arg_7_0._goTrialTipsBg.activeSelf)

	arg_7_0._clickTrialFrame = UnityEngine.Time.frameCount
end

function var_0_0._btnrecommendOnClick(arg_8_0)
	FightFailRecommendController.instance:onClickRecommend()
	arg_8_0:_udpateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(arg_8_0._episodeId, arg_8_0._receiveRecommend, arg_8_0)
end

function var_0_0._btnclothOnClock(arg_9_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._btnrestrainOnClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._btnstartseasonOnClick(arg_11_0)
	arg_11_0:_onClickStart()
end

function var_0_0._btnseasonreplayOnClick(arg_12_0)
	arg_12_0:_onClickReplay()
end

function var_0_0._btnseasonsupercardOnClick(arg_13_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_13_0 = {}

	var_13_0.pos = 4
	var_13_0.actId = Activity104Model.instance:getCurSeasonId()
	var_13_0.slot = 1
	var_13_0.group = Activity104Model.instance:getSeasonCurSnapshotSubId()

	if not Activity104Model.instance:isSeasonPosUnlock(var_13_0.actId, var_13_0.group, var_13_0.slot, var_13_0.pos) then
		return
	end

	Activity104Controller.instance:openSeasonEquipHeroView(var_13_0)
end

function var_0_0._groupDropValueChanged(arg_14_0, arg_14_1)
	GameFacade.showToast(ToastEnum.SeasonGroupChanged)

	local var_14_0 = Activity104Model.instance:getCurSeasonId()
	local var_14_1 = arg_14_1 + 1

	Activity104Rpc.instance:sendChangeFightGroupRequest(var_14_0, var_14_1)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))
	arg_15_0:_initComponent()
	arg_15_0:_initData()
	arg_15_0:_addEvents()
end

function var_0_0.onOpen(arg_16_0)
	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	arg_16_0:_checkFirstPosHasEquip()
	arg_16_0:_checkEquipClothSkill()
	arg_16_0:_refreshUI()
	arg_16_0:_checkReplay()
	arg_16_0:_refreshReplay()
	arg_16_0:_udpateRecommendEffect()
end

function var_0_0._initComponent(arg_17_0)
	arg_17_0._anim = arg_17_0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0._heroContainAnim = arg_17_0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0._btnContainAnim = arg_17_0._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initData(arg_18_0)
	gohelper.addUIClickAudio(arg_18_0._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(arg_18_0._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(arg_18_0._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(arg_18_0._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(ViewName.Season3_0HeroGroupFightView, arg_18_0._onEscapeBtnClick, arg_18_0)
	FightHelper.detectAttributeCounter()

	arg_18_0._iconGO = arg_18_0:getResInst(arg_18_0.viewContainer:getSetting().otherRes[1], arg_18_0._btncloth.gameObject)

	recthelper.setAnchor(arg_18_0._iconGO.transform, -100, 1)

	arg_18_0._tweeningId = 0
	arg_18_0._replayMode = false
	arg_18_0._multiplication = 1

	gohelper.setActive(arg_18_0._gomask, false)

	local var_18_0 = {
		luaLang("season_herogroup_one"),
		luaLang("season_herogroup_two"),
		luaLang("season_herogroup_three"),
		luaLang("season_herogroup_four")
	}

	arg_18_0._dropseasonherogroup:ClearOptions()
	arg_18_0._dropseasonherogroup:AddOptions(var_18_0)

	local var_18_1 = Activity104Model.instance:getSeasonCurSnapshotSubId()

	arg_18_0._dropseasonherogroup:SetValue(var_18_1 - 1)
	gohelper.setActive(arg_18_0._goseasoncontain, true)
	TaskDispatcher.runRepeat(arg_18_0._checkDropArrow, arg_18_0, 0)
end

function var_0_0._addEvents(arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_19_0._onOpenFullView, arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_19_0._onCloseView, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_19_0._onModifyHeroGroup, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_19_0._onModifySnapshot, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_19_0._onClickHeroGroupItem, arg_19_0)
	arg_19_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_19_0._respBeginFight, arg_19_0)
	arg_19_0:addEventCb(FightController.instance, FightEvent.RespBeginFightFail, arg_19_0._respBeginFightFail, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_19_0._playHeroGroupExitEffect, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_19_0._playCloseHeroGroupAnimation, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_19_0._onUseRecommendGroup, arg_19_0)
	arg_19_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_19_0._onCurrencyChange, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_19_0._showGuideDragEffect, arg_19_0)
	arg_19_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_19_0._heroMoveForward, arg_19_0)
	arg_19_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_19_0._switchSnapshotSubId, arg_19_0)
end

function var_0_0._checkReplay(arg_20_0)
	local var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_20_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_20_2 = var_20_1 and var_20_1.star == DungeonEnum.StarType.Advanced and var_20_1.hasRecord
	local var_20_3 = Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId)
	local var_20_4 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_20_0 and var_20_2 and not string.nilorempty(var_20_4) and not var_20_3 and cjson.decode(var_20_4)[tostring(arg_20_0._episodeId)] and not arg_20_0._replayMode then
		arg_20_0._replayMode = true
		arg_20_0._multiplication = PlayerPrefsHelper.getNumber(arg_20_0:_getMultiplicationKey(), 1)

		arg_20_0:_refreshBtns()

		arg_20_0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not arg_20_0._replayFightGroupMO then
			arg_20_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_20_0._onGetFightRecordGroupReply, arg_20_0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			arg_20_0:_switchReplayGroup()
		end
	end
end

function var_0_0._receiveRecommend(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_21_3)
end

function var_0_0._switchSnapshotSubId(arg_22_0)
	arg_22_0:_refreshMainCard()
end

function var_0_0._refreshMainCard(arg_23_0)
	gohelper.setActive(arg_23_0._gosupercardlight, false)

	local var_23_0 = Activity104EquipItemListModel.MainCharPos
	local var_23_1 = 1
	local var_23_2 = Activity104Model.instance:isSeasonPosUnlock(nil, nil, var_23_1, var_23_0)

	if var_23_2 then
		local var_23_3 = HeroGroupModel.instance:getCurGroupMO()
		local var_23_4 = "-100000"
		local var_23_5 = 0

		if var_23_3 then
			if var_23_3.isReplay then
				if var_23_3.replay_activity104Equip_data then
					local var_23_6 = var_23_3.replay_activity104Equip_data[var_23_4]

					if var_23_6 and var_23_6[var_23_1] then
						var_23_5 = var_23_6[var_23_1].equipId
					end
				end
			else
				local var_23_7 = HeroGroupModel.instance.battleConfig

				if var_23_7 and var_23_7.trialMainAct104EuqipId > 0 then
					var_23_5 = var_23_7.trialMainAct104EuqipId
				elseif var_23_3.activity104Equips and var_23_3.activity104Equips[var_23_0] then
					var_23_5 = Activity104Model.instance:getItemIdByUid(var_23_3:getAct104PosEquips(var_23_0):getEquipUID(var_23_1))
				end
			end
		end

		if var_23_5 ~= 0 then
			if not arg_23_0._superCardItem then
				arg_23_0._superCardItem = Season3_0CelebrityCardItem.New()

				arg_23_0._superCardItem:init(arg_23_0._gosupercardpos, var_23_5)
			else
				gohelper.setActive(arg_23_0._superCardItem.go, true)
				arg_23_0._superCardItem:reset(var_23_5)
			end

			gohelper.setActive(arg_23_0._gosupercardlight, true)
		elseif arg_23_0._superCardItem then
			gohelper.setActive(arg_23_0._superCardItem.go, false)
		end
	end

	gohelper.setActive(arg_23_0._gosupercardempty, var_23_2)
end

function var_0_0._checkDropArrow(arg_24_0)
	if not arg_24_0._dropherogrouparrow then
		TaskDispatcher.cancelTask(arg_24_0._checkDropArrow, arg_24_0)

		return
	end

	local var_24_0 = arg_24_0._dropseasonherogroup.transform.childCount

	if var_24_0 ~= arg_24_0._dropDownChildCount then
		arg_24_0._dropDownChildCount = var_24_0

		transformhelper.setLocalScale(arg_24_0._dropherogrouparrow, 1, var_24_0 == 5 and -1 or 1, 1)
	end
end

function var_0_0._onClickReplay(arg_25_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_25_0, var_25_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(var_25_0, var_25_1)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local var_25_2 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_25_3 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_25_4 = var_25_3 and var_25_3.hasRecord
	local var_25_5 = var_25_2 and var_25_2.firstBattleId > 0

	if not var_25_4 and var_25_5 then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and var_25_3.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not var_25_4 then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if arg_25_0._replayMode then
		arg_25_0._replayMode = false
		arg_25_0._multiplication = 1

		arg_25_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(arg_25_0._gomultispeed, false)
	else
		arg_25_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_25_0._replayMode = true
		arg_25_0._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(arg_25_0:_getMultiplicationKey(), arg_25_0._multiplication)
	arg_25_0:_refreshBtns()

	if arg_25_0._replayMode and not arg_25_0._replayFightGroupMO then
		arg_25_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_25_0._onGetFightRecordGroupReply, arg_25_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	arg_25_0:_switchReplayGroup(arg_25_0._replayMode)
end

function var_0_0._switchReplayGroup(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._goreplayready, arg_26_0._replayMode)

	local var_26_0 = arg_26_0:_haveRecord()

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_26_0._imagereplayicon, not var_26_0 and "btn_replay_lack" or arg_26_0._replayMode and "btn_replay_pause" or "btn_replay_play")

	if arg_26_1 ~= arg_26_0._replayMode then
		TaskDispatcher.cancelTask(arg_26_0._switchReplayMul, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0._switchReplayMul, arg_26_0, 0.1)
	else
		arg_26_0:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, arg_26_0._replayMode and "swicth" or "open")

	if arg_26_0._replayMode then
		arg_26_0:_updateReplayHeroGroupList()
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

		local var_26_1 = HeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_26_1)
		arg_26_0:_refreshCloth()
		arg_26_0:_refreshMainCard()
		gohelper.setActive(arg_26_0._goherogroupcontain, false)
		gohelper.setActive(arg_26_0._goherogroupcontain, true)
	end
end

function var_0_0._haveRecord(arg_27_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	local var_27_0 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)

	return var_27_0 and var_27_0.hasRecord
end

function var_0_0._updateReplayHeroGroupList(arg_28_0)
	HeroGroupModel.instance:setReplayParam(arg_28_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_28_0._replayFightGroupMO.id)
	arg_28_0:_refreshCloth()
	arg_28_0:_refreshMainCard()
	gohelper.setActive(arg_28_0._goherogroupcontain, false)
	gohelper.setActive(arg_28_0._goherogroupcontain, true)
end

function var_0_0._switchReplayMul(arg_29_0)
	arg_29_0._txtreplaycount.text = arg_29_0._replayMode and luaLang("multiple") .. arg_29_0._multiplication or ""
end

function var_0_0._heroMoveForward(arg_30_0, arg_30_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_30_1))
end

function var_0_0.isReplayMode(arg_31_0)
	return arg_31_0._replayMode
end

function var_0_0._onCurrencyChange(arg_32_0, arg_32_1)
	if not arg_32_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_32_0:_refreshBtns()
end

function var_0_0._respBeginFight(arg_33_0)
	gohelper.setActive(arg_33_0._gomask, true)

	arg_33_0._blockStart = false
end

function var_0_0._respBeginFightFail(arg_34_0)
	arg_34_0._blockStart = false
end

function var_0_0._onOpenFullView(arg_35_0, arg_35_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_36_0, arg_36_1)
	if arg_36_1 == ViewName.EquipInfoTeamShowView then
		arg_36_0:_checkFirstPosHasEquip()
	end
end

function var_0_0._getMultiplicationKey(arg_37_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_37_0._episodeId)
end

function var_0_0._udpateRecommendEffect(arg_38_0)
	gohelper.setActive(arg_38_0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(arg_38_0._episodeId))
end

function var_0_0._onEscapeBtnClick(arg_39_0)
	if not arg_39_0._gomask.gameObject.activeInHierarchy then
		arg_39_0.viewContainer:_closeCallback()
	end
end

function var_0_0._refreshUI(arg_40_0)
	local var_40_0 = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_40_0)

	arg_40_0._episodeId = HeroGroupModel.instance.episodeId
	arg_40_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_40_0._episodeId)

	arg_40_0:_refreshBtns()
	arg_40_0:_refreshCloth()
	arg_40_0:_refreshMainCard()
	arg_40_0:_setTrialNumTips()
end

function var_0_0.onClose(arg_41_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_41_0:_removeEvents()
	ZProj.TweenHelper.KillById(arg_41_0._tweeningId)
	TaskDispatcher.cancelTask(arg_41_0.openHeroGroupEditView, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._closeHeroContainAnim, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._checkDropArrow, arg_41_0)

	if arg_41_0._dragEffectLoader then
		arg_41_0._dragEffectLoader:dispose()

		arg_41_0._dragEffectLoader = nil
	end
end

function var_0_0._removeEvents(arg_42_0)
	arg_42_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_42_0._onModifySnapshot, arg_42_0)
	arg_42_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_42_0._onGetFightRecordGroupReply, arg_42_0)
end

function var_0_0._refreshReplay(arg_43_0)
	local var_43_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local var_43_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(arg_43_0._btnseasonreplay.gameObject, arg_43_0.episodeConfig and arg_43_0.episodeConfig.canUseRecord == 1)

	local var_43_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_43_3 = var_43_2 and var_43_2.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(arg_43_0._imagereplaybg, var_43_1 and var_43_3 and 1 or 0.75)

	arg_43_0._txtreplaycount.text = arg_43_0._replayMode and luaLang("multiple") .. arg_43_0._multiplication or ""

	local var_43_4 = arg_43_0._replayMode and "btn_replay_pause" or "btn_replay_play"

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_43_0._imagereplayicon, var_43_1 and var_43_3 and var_43_4 or "btn_replay_lack")
end

function var_0_0._refreshCloth(arg_44_0)
	local var_44_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_44_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_44_2 = var_44_0.clothId
	local var_44_3 = PlayerClothModel.instance:getById(var_44_2)

	gohelper.setActive(arg_44_0._txtclothname.gameObject, var_44_3)

	if var_44_3 then
		local var_44_4 = lua_cloth.configDict[var_44_3.clothId]

		if not var_44_3.level then
			local var_44_5 = 0
		end

		arg_44_0._txtclothname.text = var_44_4.name
		arg_44_0._txtclothnameen.text = var_44_4.enname
	end

	for iter_44_0, iter_44_1 in ipairs(lua_cloth.configList) do
		local var_44_6 = gohelper.findChild(arg_44_0._iconGO, tostring(iter_44_1.id))

		if not gohelper.isNil(var_44_6) then
			gohelper.setActive(var_44_6, iter_44_1.id == var_44_2)
		end
	end

	gohelper.setActive(arg_44_0._btncloth.gameObject, var_0_0.showCloth())
end

function var_0_0._checkEquipClothSkill(arg_45_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_45_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_45_0.clothId) then
		return
	end

	local var_45_1 = PlayerClothModel.instance:getList()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		if PlayerClothModel.instance:hasCloth(iter_45_1.id) then
			HeroGroupModel.instance:replaceCloth(iter_45_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_46_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_46_1 = var_46_0 and lua_battle.configDict[var_46_0.battleId]

	return var_46_0, var_46_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_47_0, var_47_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_47_1 and var_47_1.noClothSkill == 1 then
		return false
	end

	local var_47_2 = HeroGroupModel.instance:getCurGroupMO()
	local var_47_3 = PlayerClothModel.instance:getById(var_47_2.clothId)
	local var_47_4 = PlayerClothModel.instance:getList()
	local var_47_5 = false

	for iter_47_0, iter_47_1 in ipairs(var_47_4) do
		var_47_5 = true

		break
	end

	return var_47_5
end

function var_0_0._onModifyHeroGroup(arg_48_0)
	arg_48_0:_refreshCloth()
	arg_48_0:_refreshMainCard()
end

function var_0_0._onModifySnapshot(arg_49_0)
	arg_49_0:_refreshCloth()
	arg_49_0:_refreshMainCard()
end

function var_0_0._onClickHeroGroupItem(arg_50_0, arg_50_1)
	TaskDispatcher.cancelTask(arg_50_0.openHeroGroupEditView, arg_50_0)

	local var_50_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_50_1 - 1).equipUid

	arg_50_0._param = {}
	arg_50_0._param.singleGroupMOId = arg_50_1
	arg_50_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_50_1)
	arg_50_0._param.equips = var_50_0

	arg_50_0:openHeroGroupEditView()
end

function var_0_0.openHeroGroupEditView(arg_51_0)
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, arg_51_0._param)
end

function var_0_0._checkFirstPosHasEquip(arg_52_0)
	local var_52_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_52_0 then
		return
	end

	local var_52_1 = var_52_0:getPosEquips(0).equipUid
	local var_52_2 = var_52_1 and var_52_1[1]

	if var_52_2 and EquipModel.instance:getEquip(var_52_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_53_0, arg_53_1)
	if arg_53_0._dragEffectLoader then
		arg_53_0._dragEffectLoader:dispose()

		arg_53_0._dragEffectLoader = nil
	end

	if tonumber(arg_53_1) == 1 then
		arg_53_0._dragEffectLoader = PrefabInstantiate.Create(arg_53_0.viewGO)

		arg_53_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_54_0)
	local var_54_0 = string.split(arg_54_0.episodeConfig.cost, "|")
	local var_54_1 = string.split(var_54_0[1], "#")
	local var_54_2 = tonumber(var_54_1[3] or 0)
	local var_54_3 = 10104

	if HeroGroupModel.instance.episodeId == var_54_3 and not DungeonModel.instance:hasPassLevel(var_54_3) then
		local var_54_4 = HeroSingleGroupModel.instance:getList()
		local var_54_5 = 0

		for iter_54_0, iter_54_1 in ipairs(var_54_4) do
			if not iter_54_1:isEmpty() then
				var_54_5 = var_54_5 + 1
			end
		end

		if var_54_5 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_54_0:_enterFight()
end

function var_0_0._enterFight(arg_55_0)
	if arg_55_0._blockStart then
		return
	end

	arg_55_0._blockStart = true

	if HeroGroupModel.instance.episodeId then
		arg_55_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroGroup() then
			local var_55_0 = FightModel.instance:getFightParam()

			if arg_55_0._replayMode then
				var_55_0.isReplay = true
				var_55_0.multiplication = arg_55_0._multiplication

				local var_55_1 = {
					useRecord = true,
					chapterId = var_55_0.chapterId,
					episodeId = var_55_0.episodeId,
					fightParam = var_55_0,
					multiplication = arg_55_0._multiplication
				}
				local var_55_2 = Activity104Model.instance:getCurSeasonId()
				local var_55_3 = Activity104Model.instance:getBattleFinishLayer()

				Activity104Rpc.instance:sendStartAct104BattleRequest(var_55_1, var_55_2, var_55_3, var_55_0.episodeId)
			else
				var_55_0.isReplay = false
				var_55_0.multiplication = 1

				local var_55_4 = {
					multiplication = 1,
					chapterId = var_55_0.chapterId,
					episodeId = var_55_0.episodeId,
					fightParam = var_55_0
				}
				local var_55_5 = Activity104Model.instance:getCurSeasonId()
				local var_55_6 = Activity104Model.instance:getBattleFinishLayer()

				Activity104Rpc.instance:sendStartAct104BattleRequest(var_55_4, var_55_5, var_55_6, var_55_0.episodeId)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		else
			arg_55_0._blockStart = false
		end
	else
		arg_55_0._blockStart = false

		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._onUseRecommendGroup(arg_56_0)
	if arg_56_0._replayMode then
		arg_56_0._replayMode = false
		arg_56_0._multiplication = 1

		arg_56_0:_refreshBtns()
		arg_56_0:_switchReplayGroup()
	end
end

function var_0_0._refreshBtns(arg_57_0)
	local var_57_0 = not arg_57_0._replayMode and arg_57_0:_noAidHero()

	gohelper.setActive(arg_57_0._dropseasonherogroup.gameObject, var_57_0)
end

function var_0_0._onGetFightRecordGroupReply(arg_58_0, arg_58_1)
	arg_58_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_58_0._onGetFightRecordGroupReply, arg_58_0)

	arg_58_0._replayFightGroupMO = arg_58_1

	if not arg_58_0._replayMode then
		return
	end

	arg_58_0:_switchReplayGroup()
	arg_58_0:_updateReplayHeroGroup()
end

function var_0_0._updateReplayHeroGroup(arg_59_0)
	HeroGroupModel.instance:setReplayParam(arg_59_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_59_0._replayFightGroupMO.id)
	arg_59_0:_refreshCloth()
	arg_59_0:_refreshMainCard()
	gohelper.setActive(arg_59_0._goherogroupcontain, false)
	gohelper.setActive(arg_59_0._goherogroupcontain, true)
end

function var_0_0._playHeroGroupExitEffect(arg_60_0)
	arg_60_0._anim:Play("close", 0, 0)
	arg_60_0._btnContainAnim:Play("close", 0, 0)
end

function var_0_0._playCloseHeroGroupAnimation(arg_61_0)
	arg_61_0._anim:Play("close", 0, 0)
	arg_61_0._btnContainAnim:Play("close", 0, 0)

	arg_61_0._heroContainAnim.enabled = true

	arg_61_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(arg_61_0._closeHeroContainAnim, arg_61_0, 0.133)
end

function var_0_0._closeHeroContainAnim(arg_62_0)
	if arg_62_0._heroContainAnim then
		arg_62_0._heroContainAnim.enabled = false
	end
end

function var_0_0.onDestroyView(arg_63_0)
	arg_63_0._simagerole:UnLoadImage()

	if arg_63_0._superCardItem then
		arg_63_0._superCardItem:destroy()

		arg_63_0._superCardItem = nil
	end
end

function var_0_0._noAidHero(arg_64_0)
	local var_64_0 = HeroGroupModel.instance.battleId
	local var_64_1 = lua_battle.configDict[var_64_0]

	if not var_64_1 then
		return
	end

	return var_64_1.trialLimit <= 0 and string.nilorempty(var_64_1.aid) and string.nilorempty(var_64_1.trialHeros) and string.nilorempty(var_64_1.trialEquips)
end

return var_0_0
