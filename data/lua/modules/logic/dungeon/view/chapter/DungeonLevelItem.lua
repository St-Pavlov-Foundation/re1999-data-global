module("modules.logic.dungeon.view.chapter.DungeonLevelItem", package.seeall)

slot0 = class("DungeonLevelItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._txt1 = gohelper.findChildText(slot0.viewGO, "#txt_1")
	slot0._txtglow = gohelper.findChildText(slot0.viewGO, "#txt_glow")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#txt_section")
	slot0._goendline = gohelper.findChild(slot0.viewGO, "#go_endline")
	slot0._gostartline = gohelper.findChild(slot0.viewGO, "#go_startline")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "#txt_section/star/#go_star")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClick(gohelper.findChild(slot0.viewGO, "raycast"))
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_initStar()
	slot0:onUpdateParam()
end

function slot0.hideBeforeAnimation(slot0)
	if slot0._animator then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)

		slot0._animator.speed = 0

		slot0._animator:Update(0)
	end
end

function slot0.playAnimation(slot0)
	if slot0._animator then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)

		slot0._animator.speed = 1
	end
end

function slot0._playIsNewAnimation(slot0)
	if slot0._animator then
		slot0._animator:SetBool("isNew", DungeonModel.instance:getLastEpisodeShowData() and slot1.id == slot0._config.id)
	end
end

function slot0._initStar(slot0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#txt_section/star"), true)
	gohelper.setActive(slot0._gostar, true)

	slot0._starImgList = slot0:getUserDataTb_()

	for slot7 = 1, slot0._gostar.transform.childCount do
		table.insert(slot0._starImgList, slot2:GetChild(slot7 - 1):GetComponent(gohelper.Type_Image))
	end
end

function slot0.getLineStartTrans(slot0)
	return slot0._gostartline.transform
end

function slot0.getLineEndTrans(slot0)
	return slot0._goendline.transform
end

function slot0.getTrans(slot0)
	return slot0.viewGO.transform
end

function slot0.showStatus(slot0)
	slot7 = DungeonConfig.instance:getHardEpisode(slot0._config.id) and DungeonModel.instance:getEpisodeInfo(slot6.id)

	slot0:_setStar(slot0._starImgList[1], DungeonEnum.StarType.Normal <= slot0._info.star and (slot0._config.id and DungeonModel.instance:hasPassLevelAndStory(slot1)))
	gohelper.setActive(slot0._starImgList[2].gameObject, false)
	gohelper.setActive(slot0._starImgList[3].gameObject, false)

	if not string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)) then
		slot0:_setStar(slot9, DungeonEnum.StarType.Advanced <= slot5.star and slot3)
		gohelper.setActive(slot9.gameObject, true)

		if slot7 and DungeonEnum.StarType.Advanced <= slot5.star and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) and slot3 then
			slot0:_setStar(slot8, DungeonEnum.StarType.Normal <= slot7.star and slot3)
			gohelper.setActive(slot8.gameObject, true)
		end
	end
end

function slot0._setStar(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setUiFBSprite(slot1, slot2 and "star_liang" or "star_an")

	if slot2 then
		gohelper.setAsLastSibling(slot1.gameObject)
	end
end

function slot0.setGray(slot0, slot1)
	if slot1 and not slot0._graphicsContainer then
		slot0._graphicsContainer = slot0:getUserDataTb_()
		slot0._graphicsContainer.images = slot0.viewGO:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._graphicsContainer.tmps = slot0.viewGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
	end

	if slot0._graphicsContainer then
		slot2 = slot0._graphicsContainer.images:GetEnumerator()

		while slot2:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(slot2.Current.gameObject, slot1)
		end

		slot3 = slot0._graphicsContainer.tmps:GetEnumerator()

		while slot3:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(slot3.Current.gameObject, slot1)
		end
	end
end

function slot0.showEpisodeName(slot0, slot1, slot2, slot3)
	slot3.text = DungeonController.getEpisodeName(slot0)
end

function slot0.hasUnlockContent(slot0)
	return (OpenConfig.instance:getOpenShowInEpisode(slot0._config.id) or DungeonConfig.instance:getUnlockEpisodeList(slot0._config.id) or OpenConfig.instance:getOpenGroupShowInEpisode(slot0._config.id)) and not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id) or slot0._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(slot0._config.unlockEpisode)
end

function slot0.addUnlockItem(slot0, slot1)
	slot2 = MonoHelper.addLuaComOnceToGo(slot1, DungeonChapterUnlockItem, slot0._config)
end

function slot0.onUpdateParam(slot0)
	slot0._config = slot0.viewParam[1]
	slot0._info = slot0.viewParam[2]
	slot0._chapterIndex = slot0.viewParam[3]
	slot0._levelIndex = slot0.viewParam[4]

	uv0.showEpisodeName(slot0._config, slot0._chapterIndex, slot0._levelIndex, slot0._txtsection)

	slot0._txt1.text = slot0._config.name
	slot0._txtglow.text = slot0._config.name

	slot0:showStatus()

	if DungeonModel.isBattleEpisode(slot0._config) then
		slot1 = string.splitToNumber(slot0._config.icon, "#")
		slot3 = slot1[2]
		slot4, slot5 = nil

		if slot1[1] and slot3 then
			slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)
		end
	end

	slot0:setGray(not DungeonModel.instance:isCanChallenge(slot0._config))
	slot0:_playIsNewAnimation()
end

function slot0._onClickHandler(slot0)
	if not DungeonModel.isBattleEpisode(slot0._config) and DungeonModel.instance:getCantChallengeToast(slot0._config) then
		GameFacade.showToast(ToastEnum.CantChallengeToast, slot1)

		return
	end

	DungeonController.instance:enterLevelView(slot0.viewParam)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, slot0)
end

function slot0.onOpen(slot0)
	slot0._click:AddClickListener(slot0._onClickHandler, slot0)
end

function slot0.onClose(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
