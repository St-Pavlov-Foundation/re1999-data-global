module("modules.logic.herogroup.view.HeroGroupFairyLandView", package.seeall)

slot0 = class("HeroGroupFairyLandView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._onSwitchBalance, slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.BeforeEnterFight, slot0.beforeEnterFight, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.selectDreamLandCard, slot0._selectDreamLandCard, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, slot0._switchReplay, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._onSwitchBalance, slot0)
end

function slot0.beforeEnterFight(slot0)
	if slot0._isSpEpisode then
		return
	end

	slot1 = FightModel.instance:getFightParam()

	if slot0._taskConfig and slot0._cardConfig then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, slot0._cardConfig.id, slot1.episodeId)

		return
	end

	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1.episodeId).chapterId).actId == VersionActivity1_3Enum.ActivityId.Dungeon then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, 0, slot1.episodeId)

		return
	end
end

function slot0._setTaskCo(slot0)
	if not DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) or slot2.type == DungeonEnum.EpisodeType.Sp then
		slot0._isSpEpisode = true

		return
	end

	slot0._taskConfig = uv0.getDreamLandTask()
	slot0._useDreamCard = slot0._taskConfig and not string.nilorempty(slot0._taskConfig.dreamCards)
	slot0._cardConfig = slot0:_getFirstCard()

	if slot0._cloneGo then
		gohelper.destroy(slot0._cloneGo)

		slot0._cloneGo = nil
	end

	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()

		slot0._btnclick = nil
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end

	if slot0._taskConfig and slot0._cardConfig then
		slot0:_adjustHerogroupPos()
		slot0:_initFairyLandCard()
	else
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_fairylandcard"), false)
		slot0:resetUIPos()
	end

	for slot6 = 1, 4 do
		if gohelper.findChild(slot0._containerAnimator.gameObject, "hero/item" .. slot6) then
			slot8 = recthelper.rectToRelativeAnchorPos(slot0._objs[slot6].posGo.transform.position, slot0._containerAnimator.transform)

			recthelper.setAnchor(slot7.transform, slot8.x, slot8.y)
		end
	end
end

function slot0._onSwitchBalance(slot0)
	if slot0._animator then
		slot0._animator:Play("switch", 0, 0)
	end
end

function slot0.resetUIPos(slot0)
	slot0._isSetUI = false

	for slot4 = 1, 4 do
		recthelper.setAnchorX(slot0._objs[slot4].bgGo.transform, slot0._objs[slot4].bgX)
		recthelper.setAnchorX(slot0._objs[slot4].posGo.transform, slot0._objs[slot4].posX)
	end

	recthelper.setWidth(slot0._replayframe.transform, slot0._replayframeWidth)
	recthelper.setAnchorX(slot0._replayframe.transform, slot0._replayframeX)
	recthelper.setAnchorX(slot0._tip.transform, slot0._tipX)
end

function slot0._adjustHerogroupPos(slot0)
	if slot0._isSetUI then
		return
	end

	slot0._isSetUI = true
	slot0._containerAnimator.enabled = false
	slot1 = -130

	for slot5 = 1, 4 do
		recthelper.setAnchorX(slot0._objs[slot5].bgGo.transform, slot0._objs[slot5].bgX + slot1)
		recthelper.setAnchorX(slot0._objs[slot5].posGo.transform, slot0._objs[slot5].posX + slot1)
	end

	recthelper.setWidth(slot0._replayframe.transform, 1340)
	recthelper.setAnchorX(slot0._replayframe.transform, -60)
	recthelper.setAnchorX(slot0._tip.transform, -156)
end

function slot0.getDreamLandTask()
	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId).chapterId).actId ~= VersionActivity1_3Enum.ActivityId.Dungeon then
		return
	end

	for slot8, slot9 in ipairs(lua_activity126_dreamland.configList) do
		if string.find(slot9.battleIds, DungeonConfig.instance:getEpisodeBattleId(slot0.episodeId)) then
			return slot9
		end
	end
end

function slot0._initFairyLandCard(slot0)
	slot0:_loadEffect()
end

function slot0._loadEffect(slot0)
	slot0._effectUrl = "ui/viewres/herogroup/herogroupviewfairylandcard.prefab"
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:addPath(slot0._effectUrl)
	slot0._effectLoader:startLoad(slot0._effectLoaded, slot0)
end

function slot0._effectLoaded(slot0, slot1)
	slot2 = gohelper.findChild(slot0.viewGO, "#go_fairylandcard")

	gohelper.setActive(slot2, true)

	slot5 = gohelper.clone(slot1:getAssetItem(slot0._effectUrl):GetResource(slot0._effectUrl), slot2)
	slot0._cloneGo = slot5
	slot0._goflag = gohelper.findChild(slot5, "#go_fairylandcard/fairylandcard/image_story")

	gohelper.setActive(slot0._goflag, slot0._useDreamCard)

	slot0._animator = slot5:GetComponent(typeof(UnityEngine.Animator))
	slot0._gofairylandcard = gohelper.findChild(slot0.viewGO, "#go_fairylandcard/#go_fairylandcard")
	slot0._txtcardname = gohelper.findChildText(slot5, "#go_fairylandcard/fairylandcard/cardnamebg/#txt_cardname")
	slot0._imagecard = gohelper.findChildImage(slot5, "#go_fairylandcard/fairylandcard/#image_card")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot5, "#go_fairylandcard/#btn_click")

	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:_updateDreamLandCardInfo()
end

function slot0._btnclickOnClick(slot0)
	if slot0._isReplay then
		return
	end

	VersionActivity1_3BuffController.instance:openFairyLandView({
		slot0._taskConfig,
		slot0._cardConfig
	})
end

function slot0._editableInitView(slot0)
	slot5 = UnityEngine.Animator
	slot0._containerAnimator = gohelper.findChild(slot0.viewGO, "herogroupcontain"):GetComponent(typeof(slot5))
	slot0._objs = {}

	for slot5 = 1, 4 do
		slot0._objs[slot5] = slot0:getUserDataTb_()
		slot0._objs[slot5].bgGo = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot5)
		slot0._objs[slot5].posGo = gohelper.findChild(slot0.viewGO, "herogroupcontain/area/pos" .. slot5)
		slot0._objs[slot5].bgX = recthelper.getAnchorX(slot0._objs[slot5].bgGo.transform)
		slot0._objs[slot5].posX = recthelper.getAnchorX(slot0._objs[slot5].posGo.transform)
	end

	slot0._replayframe = gohelper.findChild(slot0.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	slot0._replayframeWidth = recthelper.getWidth(slot0._replayframe.transform)
	slot0._replayframeX = recthelper.getAnchorX(slot0._replayframe.transform)
	slot0._tip = gohelper.findChild(slot0.viewGO, "#go_container/#go_replayready/tip")
	slot0._tipX = recthelper.getAnchorX(slot0._tip.transform)

	slot0:_setTaskCo()

	if slot0._taskConfig and not slot0._cardConfig then
		GameFacade.showToast(ToastEnum.Activity126_tip11)
	end
end

function slot0.onOpen(slot0)
	slot0:_setTaskDes()
end

function slot0._setTaskDes(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_task")

	if not slot0._taskConfig then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_task/#go_taskitem/taskitembg/#txt_task").text = slot0._taskConfig.desc

	gohelper.setActive(slot1, true)
end

function slot0._switchReplay(slot0, slot1)
	if not slot0._taskConfig then
		return
	end

	if slot0._animator then
		slot0._animator:Play("switch", 0, 0)
	end

	slot0._isReplay = slot1

	TaskDispatcher.cancelTask(slot0._doSwitchReplay, slot0)

	if slot0._isReplay then
		TaskDispatcher.runDelay(slot0._doSwitchReplay, slot0, 0.16)
	end
end

function slot0._doSwitchReplay(slot0)
	if slot0._isReplay then
		if not HeroGroupModel.instance:getReplayParam() then
			return
		end

		if not (slot1.exInfos and slot2[1]) then
			return
		end

		if not lua_activity126_dreamland_card.configDict[slot3] then
			return
		end

		slot0:_selectDreamLandCard(slot4)
	end
end

function slot0._selectDreamLandCard(slot0, slot1)
	slot0._cardConfig = slot1

	slot0:_updateDreamLandCardInfo()
end

function slot0._updateDreamLandCardInfo(slot0)
	if not slot0._cardConfig or not slot0._imagecard then
		return
	end

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(slot0._imagecard, "v1a3_fairylandcard_" .. slot0._cardConfig.id - 2130000)

	slot0._txtcardname.text = lua_skill.configDict[slot0._cardConfig.skillId] and slot2.name
end

function slot0._getFirstCard(slot0)
	if not slot0._useDreamCard and lua_activity126_dreamland_card.configDict[PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), 0)] then
		return slot2
	end

	for slot4, slot5 in ipairs(lua_activity126_dreamland_card.configList) do
		if slot0:_hasDreamCard(slot5.id) then
			return slot5
		end
	end
end

function slot0._hasDreamCard(slot0, slot1)
	if slot0._taskConfig and slot0._useDreamCard then
		return string.find(slot0._taskConfig.dreamCards, slot1)
	end

	return Activity126Model.instance:hasDreamCard(slot1)
end

function slot0.onClose(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
	end

	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(slot0._doSwitchReplay, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._cloneGo then
		gohelper.destroy(slot0._cloneGo)

		slot0._cloneGo = nil
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()
	end
end

return slot0
