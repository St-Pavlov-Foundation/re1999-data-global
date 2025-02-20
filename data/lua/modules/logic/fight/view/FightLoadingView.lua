module("modules.logic.fight.view.FightLoadingView", package.seeall)

slot0 = class("FightLoadingView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocanvasgroup = gohelper.findChild(slot0.viewGO, "#go_canvasgroup")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "#go_canvasgroup/center/name/#txt_namecn")
	slot0._gonameen = gohelper.findChild(slot0.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn/#txt_nameen")
	slot0._txtContent = gohelper.findChildText(slot0.viewGO, "#go_canvasgroup/center/tips/#txt_describe")
	slot0._simagenamebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_canvasgroup/center/#simage_namebg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagenamebg:LoadImage(ResUrl.getFightLoadingIcon("bg_biaotiheiying"))

	slot0._canvasGroup = slot0._gocanvasgroup:GetComponent(typeof(UnityEngine.CanvasGroup))

	PostProcessingMgr.instance:setBlurWeight(1)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0._scene.director:registerCallback(FightSceneEvent.OnPrepareFinish, slot0._delayClose, slot0)
end

function slot0.onOpen(slot0)
	slot0._sceneId = slot0.viewParam
	slot0._sceneConfig = slot0._sceneId and lua_scene.configDict[slot0._sceneId]

	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Mapopen)
end

function slot0._refreshUI(slot0)
	slot0:_setRandomText()

	slot2 = FightModel.instance:getFightParam() and slot1.episodeId

	if slot2 and DungeonConfig.instance:getEpisodeCO(slot2) and slot3.type == DungeonEnum.EpisodeType.WeekWalk and not WeekWalkModel.isShallowMap(WeekWalkModel.instance:getCurMapId()) then
		slot0:_setName(lua_weekwalk_scene.configDict[WeekWalkModel.instance:getCurMapInfo().sceneId].typeName, "LIMBO")

		return
	end

	if slot0._sceneConfig then
		slot0:_setName(slot0._sceneConfig.name, slot0._sceneConfig.nameen)
	end
end

function slot0._setName(slot0, slot1, slot2)
	recthelper.setWidth(slot0._gonameen.transform, GameUtil.getTextWidthByLine(slot0._txtnamecn, slot1, 120) / 2 + 100)

	slot0._txtnamecn.text = slot1
	slot0._txtnameen.text = slot2
end

function slot0._delayClose(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, slot0._onFrame, slot0._onFinish, slot0, nil, EaseType.Linear)
end

function slot0.onClose(slot0)
end

function slot0._onFrame(slot0, slot1)
	slot0._canvasGroup.alpha = slot1
end

function slot0._onFinish(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._scene.director:unregisterCallback(FightSceneEvent.OnPrepareFinish, slot0._delayClose, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	PostProcessingMgr.instance:setBlurWeight(1)
	slot0._simagenamebg:UnLoadImage()
end

function slot0._setRandomText(slot0)
	if slot0:_getRandomCO(slot0:_getFitTips()) then
		slot0._txtContent.text = slot2.content
	end
end

function slot0._getFitTips(slot0)
	slot1 = LoadingView.getLoadingSceneType(SceneType.Fight)
	slot2 = PlayerModel.instance:getPlayerLevel()
	slot3 = {}

	for slot7, slot8 in pairs(lua_loading_text.configList) do
		slot13 = "#"

		for slot13, slot14 in pairs(FightStrUtil.instance:getSplitToNumberCache(slot8.scenes, slot13)) do
			if slot14 == slot1 then
				if slot2 == 0 then
					table.insert(slot3, slot8)
				elseif slot8.unlocklevel <= slot2 then
					table.insert(slot3, slot8)
				end
			end
		end
	end

	return slot3
end

function slot0._getRandomCO(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot2 = 0 + slot7.weight
	end

	for slot7, slot8 in ipairs(slot1) do
		if math.floor(math.random() * slot2) < slot8.weight then
			return slot8
		else
			slot3 = slot3 - slot8.weight
		end
	end

	if #slot1 > 1 then
		return slot1[math.random(1, slot4)]
	elseif slot4 == 1 then
		return slot1[1]
	end
end

return slot0
