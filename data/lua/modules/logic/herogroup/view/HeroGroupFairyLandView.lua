module("modules.logic.herogroup.view.HeroGroupFairyLandView", package.seeall)

local var_0_0 = class("HeroGroupFairyLandView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_2_0._onSwitchBalance, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.BeforeEnterFight, arg_2_0.beforeEnterFight, arg_2_0)
	arg_2_0:addEventCb(Activity126Controller.instance, Activity126Event.selectDreamLandCard, arg_2_0._selectDreamLandCard, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, arg_2_0._switchReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._onSwitchBalance, arg_3_0)
end

function var_0_0.beforeEnterFight(arg_4_0)
	if arg_4_0._isSpEpisode then
		return
	end

	local var_4_0 = FightModel.instance:getFightParam()

	if arg_4_0._taskConfig and arg_4_0._cardConfig then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, arg_4_0._cardConfig.id, var_4_0.episodeId)

		return
	end

	local var_4_1 = DungeonConfig.instance:getEpisodeCO(var_4_0.episodeId).chapterId

	if DungeonConfig.instance:getChapterCO(var_4_1).actId == VersionActivity1_3Enum.ActivityId.Dungeon then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, 0, var_4_0.episodeId)

		return
	end
end

function var_0_0._setTaskCo(arg_5_0)
	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1 = DungeonConfig.instance:getEpisodeCO(var_5_0.episodeId)

	if not var_5_1 or var_5_1.type == DungeonEnum.EpisodeType.Sp then
		arg_5_0._isSpEpisode = true

		return
	end

	arg_5_0._taskConfig = var_0_0.getDreamLandTask()
	arg_5_0._useDreamCard = arg_5_0._taskConfig and not string.nilorempty(arg_5_0._taskConfig.dreamCards)
	arg_5_0._cardConfig = arg_5_0:_getFirstCard()

	if arg_5_0._cloneGo then
		gohelper.destroy(arg_5_0._cloneGo)

		arg_5_0._cloneGo = nil
	end

	if arg_5_0._btnclick then
		arg_5_0._btnclick:RemoveClickListener()

		arg_5_0._btnclick = nil
	end

	if arg_5_0._effectLoader then
		arg_5_0._effectLoader:dispose()

		arg_5_0._effectLoader = nil
	end

	if arg_5_0._taskConfig and arg_5_0._cardConfig then
		arg_5_0:_adjustHerogroupPos()
		arg_5_0:_initFairyLandCard()
	else
		local var_5_2 = gohelper.findChild(arg_5_0.viewGO, "#go_fairylandcard")

		gohelper.setActive(var_5_2, false)
		arg_5_0:resetUIPos()
	end

	for iter_5_0 = 1, 4 do
		local var_5_3 = gohelper.findChild(arg_5_0._containerAnimator.gameObject, "hero/item" .. iter_5_0)

		if var_5_3 then
			local var_5_4 = recthelper.rectToRelativeAnchorPos(arg_5_0._objs[iter_5_0].posGo.transform.position, arg_5_0._containerAnimator.transform)

			recthelper.setAnchor(var_5_3.transform, var_5_4.x, var_5_4.y)
		end
	end
end

function var_0_0._onSwitchBalance(arg_6_0)
	if arg_6_0._animator then
		arg_6_0._animator:Play("switch", 0, 0)
	end
end

function var_0_0.resetUIPos(arg_7_0)
	arg_7_0._isSetUI = false

	for iter_7_0 = 1, 4 do
		recthelper.setAnchorX(arg_7_0._objs[iter_7_0].bgGo.transform, arg_7_0._objs[iter_7_0].bgX)
		recthelper.setAnchorX(arg_7_0._objs[iter_7_0].posGo.transform, arg_7_0._objs[iter_7_0].posX)
	end

	recthelper.setWidth(arg_7_0._replayframe.transform, arg_7_0._replayframeWidth)
	recthelper.setAnchorX(arg_7_0._replayframe.transform, arg_7_0._replayframeX)
	recthelper.setAnchorX(arg_7_0._tip.transform, arg_7_0._tipX)
end

function var_0_0._adjustHerogroupPos(arg_8_0)
	if arg_8_0._isSetUI then
		return
	end

	arg_8_0._isSetUI = true
	arg_8_0._containerAnimator.enabled = false

	local var_8_0 = -130

	for iter_8_0 = 1, 4 do
		recthelper.setAnchorX(arg_8_0._objs[iter_8_0].bgGo.transform, arg_8_0._objs[iter_8_0].bgX + var_8_0)
		recthelper.setAnchorX(arg_8_0._objs[iter_8_0].posGo.transform, arg_8_0._objs[iter_8_0].posX + var_8_0)
	end

	recthelper.setWidth(arg_8_0._replayframe.transform, 1340)
	recthelper.setAnchorX(arg_8_0._replayframe.transform, -60)
	recthelper.setAnchorX(arg_8_0._tip.transform, -156)
end

function var_0_0.getDreamLandTask()
	local var_9_0 = FightModel.instance:getFightParam()
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0.episodeId).chapterId

	if DungeonConfig.instance:getChapterCO(var_9_1).actId ~= VersionActivity1_3Enum.ActivityId.Dungeon then
		return
	end

	local var_9_2 = DungeonConfig.instance:getEpisodeBattleId(var_9_0.episodeId)

	for iter_9_0, iter_9_1 in ipairs(lua_activity126_dreamland.configList) do
		if string.find(iter_9_1.battleIds, var_9_2) then
			return iter_9_1
		end
	end
end

function var_0_0._initFairyLandCard(arg_10_0)
	arg_10_0:_loadEffect()
end

function var_0_0._loadEffect(arg_11_0)
	arg_11_0._effectUrl = "ui/viewres/herogroup/herogroupviewfairylandcard.prefab"
	arg_11_0._effectLoader = MultiAbLoader.New()

	arg_11_0._effectLoader:addPath(arg_11_0._effectUrl)
	arg_11_0._effectLoader:startLoad(arg_11_0._effectLoaded, arg_11_0)
end

function var_0_0._effectLoaded(arg_12_0, arg_12_1)
	local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "#go_fairylandcard")

	gohelper.setActive(var_12_0, true)

	local var_12_1 = arg_12_1:getAssetItem(arg_12_0._effectUrl):GetResource(arg_12_0._effectUrl)
	local var_12_2 = gohelper.clone(var_12_1, var_12_0)

	arg_12_0._cloneGo = var_12_2
	arg_12_0._goflag = gohelper.findChild(var_12_2, "#go_fairylandcard/fairylandcard/image_story")

	gohelper.setActive(arg_12_0._goflag, arg_12_0._useDreamCard)

	arg_12_0._animator = var_12_2:GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._gofairylandcard = gohelper.findChild(arg_12_0.viewGO, "#go_fairylandcard/#go_fairylandcard")
	arg_12_0._txtcardname = gohelper.findChildText(var_12_2, "#go_fairylandcard/fairylandcard/cardnamebg/#txt_cardname")
	arg_12_0._imagecard = gohelper.findChildImage(var_12_2, "#go_fairylandcard/fairylandcard/#image_card")
	arg_12_0._btnclick = gohelper.findChildButtonWithAudio(var_12_2, "#go_fairylandcard/#btn_click")

	arg_12_0._btnclick:AddClickListener(arg_12_0._btnclickOnClick, arg_12_0)
	arg_12_0:_updateDreamLandCardInfo()
end

function var_0_0._btnclickOnClick(arg_13_0)
	if arg_13_0._isReplay then
		return
	end

	VersionActivity1_3BuffController.instance:openFairyLandView({
		arg_13_0._taskConfig,
		arg_13_0._cardConfig
	})
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._containerAnimator = gohelper.findChild(arg_14_0.viewGO, "herogroupcontain"):GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._objs = {}

	for iter_14_0 = 1, 4 do
		arg_14_0._objs[iter_14_0] = arg_14_0:getUserDataTb_()
		arg_14_0._objs[iter_14_0].bgGo = gohelper.findChild(arg_14_0.viewGO, "herogroupcontain/hero/bg" .. iter_14_0)
		arg_14_0._objs[iter_14_0].posGo = gohelper.findChild(arg_14_0.viewGO, "herogroupcontain/area/pos" .. iter_14_0)
		arg_14_0._objs[iter_14_0].bgX = recthelper.getAnchorX(arg_14_0._objs[iter_14_0].bgGo.transform)
		arg_14_0._objs[iter_14_0].posX = recthelper.getAnchorX(arg_14_0._objs[iter_14_0].posGo.transform)
	end

	arg_14_0._replayframe = gohelper.findChild(arg_14_0.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	arg_14_0._replayframeWidth = recthelper.getWidth(arg_14_0._replayframe.transform)
	arg_14_0._replayframeX = recthelper.getAnchorX(arg_14_0._replayframe.transform)
	arg_14_0._tip = gohelper.findChild(arg_14_0.viewGO, "#go_container/#go_replayready/tip")
	arg_14_0._tipX = recthelper.getAnchorX(arg_14_0._tip.transform)

	arg_14_0:_setTaskCo()

	if arg_14_0._taskConfig and not arg_14_0._cardConfig then
		GameFacade.showToast(ToastEnum.Activity126_tip11)
	end
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_setTaskDes()
end

function var_0_0._setTaskDes(arg_16_0)
	local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "#go_container/#scroll_info/infocontain/#go_task")

	if not arg_16_0._taskConfig then
		gohelper.setActive(var_16_0, false)

		return
	end

	gohelper.findChildText(arg_16_0.viewGO, "#go_container/#scroll_info/infocontain/#go_task/#go_taskitem/taskitembg/#txt_task").text = arg_16_0._taskConfig.desc

	gohelper.setActive(var_16_0, true)
end

function var_0_0._switchReplay(arg_17_0, arg_17_1)
	if not arg_17_0._taskConfig then
		return
	end

	if arg_17_0._animator then
		arg_17_0._animator:Play("switch", 0, 0)
	end

	arg_17_0._isReplay = arg_17_1

	TaskDispatcher.cancelTask(arg_17_0._doSwitchReplay, arg_17_0)

	if arg_17_0._isReplay then
		TaskDispatcher.runDelay(arg_17_0._doSwitchReplay, arg_17_0, 0.16)
	end
end

function var_0_0._doSwitchReplay(arg_18_0)
	if arg_18_0._isReplay then
		local var_18_0 = HeroGroupModel.instance:getReplayParam()

		if not var_18_0 then
			return
		end

		local var_18_1 = var_18_0.exInfos
		local var_18_2 = var_18_1 and var_18_1[1]

		if not var_18_2 then
			return
		end

		local var_18_3 = lua_activity126_dreamland_card.configDict[var_18_2]

		if not var_18_3 then
			return
		end

		arg_18_0:_selectDreamLandCard(var_18_3)
	end
end

function var_0_0._selectDreamLandCard(arg_19_0, arg_19_1)
	arg_19_0._cardConfig = arg_19_1

	arg_19_0:_updateDreamLandCardInfo()
end

function var_0_0._updateDreamLandCardInfo(arg_20_0)
	if not arg_20_0._cardConfig or not arg_20_0._imagecard then
		return
	end

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(arg_20_0._imagecard, "v1a3_fairylandcard_" .. arg_20_0._cardConfig.id - 2130000)

	local var_20_0 = arg_20_0._cardConfig.skillId
	local var_20_1 = lua_skill.configDict[var_20_0]

	arg_20_0._txtcardname.text = var_20_1 and var_20_1.name
end

function var_0_0._getFirstCard(arg_21_0)
	if not arg_21_0._useDreamCard then
		local var_21_0 = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), 0)
		local var_21_1 = lua_activity126_dreamland_card.configDict[var_21_0]

		if var_21_1 then
			return var_21_1
		end
	end

	for iter_21_0, iter_21_1 in ipairs(lua_activity126_dreamland_card.configList) do
		if arg_21_0:_hasDreamCard(iter_21_1.id) then
			return iter_21_1
		end
	end
end

function var_0_0._hasDreamCard(arg_22_0, arg_22_1)
	if arg_22_0._taskConfig and arg_22_0._useDreamCard then
		return string.find(arg_22_0._taskConfig.dreamCards, arg_22_1)
	end

	return Activity126Model.instance:hasDreamCard(arg_22_1)
end

function var_0_0.onClose(arg_23_0)
	if arg_23_0._btnclick then
		arg_23_0._btnclick:RemoveClickListener()
	end

	if arg_23_0._animator then
		arg_23_0._animator.enabled = true

		arg_23_0._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(arg_23_0._doSwitchReplay, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._cloneGo then
		gohelper.destroy(arg_24_0._cloneGo)

		arg_24_0._cloneGo = nil
	end

	if arg_24_0._effectLoader then
		arg_24_0._effectLoader:dispose()
	end
end

return var_0_0
