module("modules.logic.seasonver.act123.view1_8.Season123_1_8StoryView", package.seeall)

slot0 = class("Season123_1_8StoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocoverPage = gohelper.findChild(slot0.viewGO, "Root/#go_coverPage")
	slot0._txtcoverTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_coverPage/Left/Title/txt_Title")
	slot0._txttitleDesc = gohelper.findChildText(slot0.viewGO, "Root/#go_coverPage/Left/#txt_titleDesc")
	slot0._simageCover = gohelper.findChildSingleImage(slot0.viewGO, "Root/#go_coverPage/Left/#simage_Cover")
	slot0._gocoverContent = gohelper.findChild(slot0.viewGO, "Root/#go_coverPage/Right/#go_coverContent")
	slot0._gocoverItem = gohelper.findChild(slot0.viewGO, "Root/#go_coverPage/Right/#go_coverContent/#go_coverItem")
	slot0._godetailPage = gohelper.findChild(slot0.viewGO, "Root/#go_detailPage")
	slot0._txtdetailTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	slot0._simagePolaroid = gohelper.findChildSingleImage(slot0.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	slot0._txtdetailPageTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	slot0._txtAuthor = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	slot0._scrollDesc = gohelper.findChildScrollRect(slot0.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0._goLeftTop = gohelper.findChild(slot0.viewGO, "#go_LeftTop")
	slot0._animView = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OnCoverItemClick, slot0.onCoverItemClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
	slot0:removeEventCb(Season123Controller.instance, Season123Event.OnCoverItemClick, slot0.onCoverItemClick, slot0)
end

function slot0._btnLeftOnClick(slot0)
	slot0.curPageIndex = Mathf.Max(0, slot0.curPageIndex - 1)

	if slot0.curPageIndex == 0 then
		slot0:showSwitchPageAnim("tocover")
	else
		slot0:showSwitchPageAnim("toleft")
	end
end

function slot0._btnRightOnClick(slot0)
	if slot0.coverItemList[math.min(slot0.curPageIndex + 1, slot0.maxPageIndex)].item.isUnlock then
		slot0.curPageIndex = Mathf.Min(slot0.curPageIndex + 1, slot0.maxPageIndex)

		if slot0.curPageIndex == 1 then
			slot0:showSwitchPageAnim("todetail")
		else
			slot0:showSwitchPageAnim("toright")
		end
	else
		GameFacade.showToast(ToastEnum.SeasonStageNotPass)
	end
end

function slot0._editableInitView(slot0)
	slot0.coverItemTab = slot0:getUserDataTb_()
	slot0.coverItemList = slot0:getUserDataTb_()
	slot0.unlockStateTab = slot0:getUserDataTb_()
	slot0.saveUnlockStateTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gocoverItem, false)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	slot0.actId = slot0.viewParam.actId
	slot0.allStoryConfig = Season123Config.instance:getAllStoryCo(slot0.actId)
	slot0.maxPageIndex = GameUtil.getTabLen(slot0.allStoryConfig)
	slot0.curPageIndex = 0

	slot0:initCoverPageUI()
	slot0:createCoverItem()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gocoverPage, true)
	gohelper.setActive(slot0._godetailPage, slot0.curPageIndex > 0)
	gohelper.setActive(slot0._btnLeft.gameObject, slot0.curPageIndex > 0)
	ZProj.UGUIHelper.SetColorAlpha(slot0._btnRight.gameObject:GetComponent(typeof(UnityEngine.UI.Image)), slot0.coverItemList[math.min(slot0.curPageIndex + 1, slot0.maxPageIndex)].item.isUnlock and 1 or 0.2)
	gohelper.setActive(slot0._btnRight.gameObject, slot0.curPageIndex < slot0.maxPageIndex)

	if slot0.curPageIndex > 0 then
		slot0:refreshDetailPageUI()
	end

	slot0:refreshUnlockState()
end

function slot0.initCoverPageUI(slot0)
	slot0._simageCover:LoadImage(string.format("singlebg/%s", Season123Config.instance:getSeasonConstStr(slot0.actId, Activity123Enum.Const.StoryCoverIconUrl)))

	slot0._txttitleDesc.text = luaLang("activity123_overseas_11700_1")
	slot0._txtcoverTitle.text = luaLang("activity123_overseas_11700_2")
end

function slot0.refreshDetailPageUI(slot0)
	slot1 = Season123Config.instance:getStoryConfig(slot0.actId, slot0.curPageIndex)
	slot0._txtdetailTitle.text = GameUtil.setFirstStrSize(slot1.title, 80)

	slot0._simagePolaroid:LoadImage(Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", slot1.picture, slot0.actId))

	slot0._txtdetailPageTitle.text = slot1.subTitle
	slot0._txtAuthor.text = slot1.subContent

	gohelper.setActive(slot0._txtAuthor.gameObject, not string.nilorempty(slot1.subContent))
	recthelper.setHeight(slot0._scrollDesc.gameObject.transform, string.nilorempty(slot1.subContent) and 705 or 585)

	slot0._scrollDesc.verticalNormalizedPosition = 1
	slot0._txtdesc.text = slot1.content
end

function slot0.createCoverItem(slot0)
	for slot5, slot6 in pairs(Season123Config.instance:getAllStoryCo(slot0.actId)) do
		if not slot0.coverItemTab[slot5] then
			slot7 = {
				go = gohelper.clone(slot0._gocoverItem, slot0._gocoverContent, "cover" .. slot5)
			}
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, Season123_1_8StoryCoverItem, {
				actId = slot0.actId,
				storyId = slot5,
				storyConfig = slot6
			})
			slot0.coverItemTab[slot5] = slot7

			table.insert(slot0.coverItemList, slot7)
		end

		slot7.item:refreshItem()

		slot0.unlockStateTab[slot5] = slot7.item.isUnlock

		gohelper.setActive(slot7.go, true)
	end
end

function slot0.refreshUnlockState(slot0)
	slot2 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0:getLocalKey(), "")) then
		for slot6, slot7 in ipairs(cjson.decode(slot1)) do
			slot8 = string.split(slot7, "|")
			slot0.saveUnlockStateTab[tonumber(slot8[1])] = slot0:setStrToBool(slot8[2])
		end
	end

	for slot6, slot7 in pairs(slot0.coverItemTab) do
		if GameUtil.getTabLen(slot0.saveUnlockStateTab) == 0 then
			slot7.item:refreshUnlockState(false)
		else
			slot7.item:refreshUnlockState(slot0.saveUnlockStateTab[slot6])
		end
	end

	slot0:saveUnlockState()
end

function slot0.getLocalKey(slot0)
	return "Season123StoryUnlock" .. "#" .. tostring(slot0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.saveUnlockState(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.unlockStateTab) do
		table.insert(slot1, string.format("%s|%s", slot5, slot6))
	end

	PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot1))
end

function slot0.setStrToBool(slot0, slot1)
	if string.nilorempty(slot1) then
		return false
	elseif slot1 == "true" then
		return true
	else
		return false
	end
end

function slot0.onCoverItemClick(slot0, slot1)
	slot0.curPageIndex = slot1.storyId

	slot0:showSwitchPageAnim("todetail")
end

function slot0.showSwitchPageAnim(slot0, slot1)
	slot0._animView.enabled = true

	slot0._animView:Play(slot1, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_screenplay_photo_close)
	UIBlockMgr.instance:startBlock("playSwitchPageAnim")
	TaskDispatcher.runDelay(slot0.refreshPage, slot0, 0.3)
end

function slot0.refreshPage(slot0)
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
	TaskDispatcher.cancelTask(slot0.refreshPage, slot0)
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	Season123Controller.instance:checkHasReadUnlockStory(slot0.actId)
end

function slot0.onDestroyView(slot0)
	slot0._simageCover:UnLoadImage()
	slot0._simagePolaroid:UnLoadImage()
end

return slot0
