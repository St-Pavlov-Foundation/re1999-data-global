module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailView", package.seeall)

slot0 = class("Activity132CollectDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnRightArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rightarrow")
	slot0.btnLeftArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_leftarrow")
	slot0.simageRightBg = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_rightbg")
	slot0.simageImg = gohelper.findChildImage(slot0.viewGO, "Right/#simage_img")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Right/txt_Title")
	slot0.txtTitleEn = gohelper.findChildTextMesh(slot0.viewGO, "Right/txt_Title/txt_TitleEn")
	slot0.goContentItem = gohelper.findChild(slot0.viewGO, "Right/Scroll View/Viewport/Content/goContentItem")

	gohelper.setActive(slot0.goContentItem, false)

	slot0.contentItemList = {}
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "emptyBg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnRightArrow, slot0.onClickRightBtn, slot0)
	slot0:addClickCb(slot0.btnLeftArrow, slot0.onClickLeftBtn, slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickClose, slot0)
	slot0:addEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, slot0.onContentUnlock, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnRightArrow)
	slot0:removeClickCb(slot0.btnLeftArrow)
	slot0:removeClickCb(slot0.btnClose)
	slot0:removeEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, slot0.onContentUnlock, slot0)
end

function slot0._editableInitView(slot0)
	slot0.simageRightBg:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_rightbg.png")
end

function slot0.onUpdateParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.collectId = slot0.viewParam.collectId
	slot0.clueId = slot0.viewParam.clueId

	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.collectId = slot0.viewParam.collectId
	slot0.clueId = slot0.viewParam.clueId

	slot0:refreshUI()
end

function slot0.onClickRightBtn(slot0)
	slot3 = Activity132Model.instance:getActMoById(slot0.actId):getCollectMo(slot0.collectId):getClueList()
	slot4 = #slot3
	slot5 = nil

	for slot9, slot10 in ipairs(slot3) do
		if slot10.clueId == slot0.clueId then
			slot5 = slot9

			break
		end
	end

	if slot5 then
		if slot5 + 1 < 1 then
			slot6 = slot4
		end

		if slot4 < slot6 then
			slot6 = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, slot6)
	end
end

function slot0.onClickLeftBtn(slot0)
	slot3 = Activity132Model.instance:getActMoById(slot0.actId):getCollectMo(slot0.collectId):getClueList()
	slot4 = #slot3
	slot5 = nil

	for slot9, slot10 in ipairs(slot3) do
		if slot10.clueId == slot0.clueId then
			slot5 = slot9

			break
		end
	end

	if slot5 then
		if slot5 - 1 < 1 then
			slot6 = slot4
		end

		if slot4 < slot6 then
			slot6 = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, slot6)
	end
end

function slot0.refreshUI(slot0)
	slot2 = Activity132Config.instance:getClueConfig(slot0.actId, slot0.clueId)
	slot3 = Activity132Config.instance:getCollectConfig(slot0.actId, slot0.collectId).name
	slot4 = GameUtil.utf8sub(slot3, 1, 1)
	slot5 = ""

	if GameUtil.utf8len(slot3) >= 2 then
		slot5 = GameUtil.utf8sub(slot3, 2, slot6 - 1)
	end

	slot0.txtTitle.text = string.format("<size=66>%s</size>%s", slot4, slot5)
	slot0.txtTitleEn.text = slot1.nameEn

	UISpriteSetMgr.instance:setV1a4CollectSprite(slot0.simageImg, slot2.smallBg, true)
	slot0:refreshContents()
end

function slot0.refreshContents(slot0)
	slot5 = {}

	for slot10, slot11 in ipairs(Activity132Model.instance:getActMoById(slot0.actId):getCollectMo(slot0.collectId):getClueMo(slot0.clueId):getContentList()) do
		table.insert(slot5, slot11)

		if slot1:getContentState(slot11.contentId) == Activity132Enum.ContentState.CanUnlock then
			table.insert({}, slot11.contentId)
		end
	end

	slot12 = #slot5

	for slot12 = 1, math.max(#slot0.contentItemList, slot12) do
		if not slot0.contentItemList[slot12] then
			table.insert(slot0.contentItemList, slot0:createContentItem(slot12))
		end

		slot13:setData(slot5[slot12])
	end

	if #slot6 > 0 then
		Activity132Rpc.instance:sendAct132UnlockRequest(slot0.actId, slot6)
	end
end

function slot0.createContentItem(slot0, slot1)
	return Activity132CollectDetailItem.New(gohelper.cloneInPlace(slot0.goContentItem, string.format("item%s", slot1)))
end

function slot0.onContentUnlock(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {
		[slot1[slot6]] = 1
	}

	for slot6 = 1, #slot1 do
	end

	for slot6, slot7 in ipairs(slot0.contentItemList) do
		if slot7.data and slot2[slot7.data.contentId] then
			slot7:playUnlock()
		end
	end
end

function slot0.onClickClose(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0.simageRightBg:UnLoadImage()
end

return slot0
