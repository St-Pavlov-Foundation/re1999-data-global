module("modules.logic.rouge.view.RougeReviewItem", package.seeall)

slot0 = class("RougeReviewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goUnlocked = gohelper.findChild(slot0.viewGO, "#go_Unlocked")
	slot0._simageItemPic = gohelper.findChildSingleImage(slot0.viewGO, "#go_Unlocked/#simage_ItemPic")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_Unlocked/#go_new")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/#txt_Name")
	slot0._txtNameEn = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Unlocked/#btn_Play")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_desc")
	slot0._txtUnknown = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_Unknown")
	slot0._goLine = gohelper.findChild(slot0.viewGO, "#go_Line")
	slot0._goLine1 = gohelper.findChild(slot0.viewGO, "#go_Line/#go_Line1")
	slot0._goLine2 = gohelper.findChild(slot0.viewGO, "#go_Line/#go_Line2")
	slot0._goLine3 = gohelper.findChild(slot0.viewGO, "#go_Line/#go_Line3")
	slot0._goLine4 = gohelper.findChild(slot0.viewGO, "#go_Line/#go_Line4")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlay:AddClickListener(slot0._btnPlayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlay:RemoveClickListener()
end

function slot0._btnPlayOnClick(slot0)
	slot1 = {}

	if not string.nilorempty(slot0._config.levelIdDict) then
		for slot6, slot7 in ipairs(string.split(slot0._config.levelIdDict, "|")) do
			slot8 = string.splitToNumber(slot7, "#")
			slot1[slot8[1]] = slot8[2]
		end
	end

	StoryController.instance:playStories(slot0._mo.storyIdList, {
		levelIdDict = slot1,
		isReplay = true
	})

	if slot0._showNewFlag then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Story, slot0._mo.config.id, slot0._updateNewFlag, slot0)
	end
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._mo = slot1
	slot0._config = slot1.config
	slot0._isEnd = slot2
	slot0._reviewView = slot3
	slot0._path = slot5

	slot0:_updateInfo()
	slot0:_initNodes(slot4)
	slot0:_updateNewFlag()
end

function slot0._updateNewFlag(slot0)
	slot0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Story, slot0._mo.config.id) ~= nil

	gohelper.setActive(slot0._gonew, slot0._showNewFlag)
end

function slot0._initNodes(slot0, slot1)
	if not slot0._isUnlock then
		return
	end

	if not slot1 or #slot1 <= 1 then
		gohelper.setActive(slot0._goLine1, not slot0._isEnd)

		if slot1 and slot2 then
			for slot6, slot7 in ipairs(slot1) do
				slot0:_showNodeText(slot7, slot0._goLine1, slot6)
			end
		end

		return
	end

	slot6 = true

	gohelper.setActive(slot0["_goLine" .. #slot1], slot6)

	for slot6, slot7 in ipairs(slot1) do
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._reviewView:getResInst(slot0._path, gohelper.findChild(slot2, "#go_End" .. slot6), "item" .. slot7.config.id), uv0)
		slot10._showLock = true

		slot10:onUpdateMO(slot7, true)
		slot0:_showNodeText(slot7, slot2, slot6)
	end
end

function slot0._showNodeText(slot0, slot1, slot2, slot3)
	if slot1 and slot0:_isUnlockStory(slot1) then
		gohelper.findChildText(slot2, string.format("image_Line/image_Line%s/#txt_Descr%s", slot3, slot3)).text = slot1.config.desc
	end
end

function slot0._updateInfo(slot0)
	slot0._isUnlock = slot0:_isUnlockStory(slot0._mo)

	gohelper.setActive(slot0._goUnlocked, slot0._isUnlock)
	gohelper.setActive(slot0._goLocked, not slot0._isUnlock and (slot0._showLock or slot0._index == 1))

	if not slot0._isUnlock then
		return
	end

	slot0._txtName.text = slot0._config.name
	slot0._txtNameEn.text = slot0._config.nameEn

	slot0._simageItemPic:LoadImage(slot0._config.image)
end

function slot0.isUnlock(slot0)
	return slot0._isUnlock
end

function slot0.setMaxUnlockStateId(slot0, slot1)
	slot0._maxUnlockStateId = slot1
end

function slot0._isUnlockStory(slot0, slot1)
	if slot0._maxUnlockStateId and slot1.config.stageId <= slot0._maxUnlockStateId then
		return true
	end

	slot2 = slot1.storyIdList

	return RougeOutsideModel.instance:storyIsPass(slot2[#slot2])
end

function slot0.onDestroyView(slot0)
end

return slot0
