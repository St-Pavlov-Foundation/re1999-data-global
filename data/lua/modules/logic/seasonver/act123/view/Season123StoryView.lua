module("modules.logic.seasonver.act123.view.Season123StoryView", package.seeall)

local var_0_0 = class("Season123StoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocoverPage = gohelper.findChild(arg_1_0.viewGO, "Root/#go_coverPage")
	arg_1_0._txtcoverTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_coverPage/Left/Title/txt_Title")
	arg_1_0._txttitleDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_coverPage/Left/#txt_titleDesc")
	arg_1_0._simageCover = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#go_coverPage/Left/#simage_Cover")
	arg_1_0._gocoverContent = gohelper.findChild(arg_1_0.viewGO, "Root/#go_coverPage/Right/#go_coverContent")
	arg_1_0._gocoverItem = gohelper.findChild(arg_1_0.viewGO, "Root/#go_coverPage/Right/#go_coverContent/#go_coverItem")
	arg_1_0._godetailPage = gohelper.findChild(arg_1_0.viewGO, "Root/#go_detailPage")
	arg_1_0._txtdetailTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	arg_1_0._simagePolaroid = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	arg_1_0._txtdetailPageTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	arg_1_0._txtAuthor = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	arg_1_0._scrollDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0._goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTop")
	arg_1_0._animView = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.OnCoverItemClick, arg_2_0.onCoverItemClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.OnCoverItemClick, arg_3_0.onCoverItemClick, arg_3_0)
end

function var_0_0._btnLeftOnClick(arg_4_0)
	arg_4_0.curPageIndex = Mathf.Max(0, arg_4_0.curPageIndex - 1)

	if arg_4_0.curPageIndex == 0 then
		arg_4_0:showSwitchPageAnim("tocover")
	else
		arg_4_0:showSwitchPageAnim("toleft")
	end
end

function var_0_0._btnRightOnClick(arg_5_0)
	local var_5_0 = math.min(arg_5_0.curPageIndex + 1, arg_5_0.maxPageIndex)

	if arg_5_0.coverItemList[var_5_0].item.isUnlock then
		arg_5_0.curPageIndex = Mathf.Min(arg_5_0.curPageIndex + 1, arg_5_0.maxPageIndex)

		if arg_5_0.curPageIndex == 1 then
			arg_5_0:showSwitchPageAnim("todetail")
		else
			arg_5_0:showSwitchPageAnim("toright")
		end
	else
		GameFacade.showToast(ToastEnum.SeasonStageNotPass)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.coverItemTab = arg_6_0:getUserDataTb_()
	arg_6_0.coverItemList = arg_6_0:getUserDataTb_()
	arg_6_0.unlockStateTab = arg_6_0:getUserDataTb_()
	arg_6_0.saveUnlockStateTab = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._gocoverItem, false)
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	arg_7_0.actId = arg_7_0.viewParam.actId
	arg_7_0.allStoryConfig = Season123Config.instance:getAllStoryCo(arg_7_0.actId)
	arg_7_0.maxPageIndex = GameUtil.getTabLen(arg_7_0.allStoryConfig)
	arg_7_0.curPageIndex = 0

	arg_7_0:initCoverPageUI()
	arg_7_0:createCoverItem()
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	gohelper.setActive(arg_8_0._gocoverPage, true)
	gohelper.setActive(arg_8_0._godetailPage, arg_8_0.curPageIndex > 0)
	gohelper.setActive(arg_8_0._btnLeft.gameObject, arg_8_0.curPageIndex > 0)

	local var_8_0 = math.min(arg_8_0.curPageIndex + 1, arg_8_0.maxPageIndex)
	local var_8_1 = arg_8_0.coverItemList[var_8_0].item.isUnlock

	ZProj.UGUIHelper.SetColorAlpha(arg_8_0._btnRight.gameObject:GetComponent(typeof(UnityEngine.UI.Image)), var_8_1 and 1 or 0.2)
	gohelper.setActive(arg_8_0._btnRight.gameObject, arg_8_0.curPageIndex < arg_8_0.maxPageIndex)

	if arg_8_0.curPageIndex > 0 then
		arg_8_0:refreshDetailPageUI()
	end

	arg_8_0:refreshUnlockState()
end

function var_0_0.initCoverPageUI(arg_9_0)
	local var_9_0 = string.format("singlebg/%s", Season123Config.instance:getSeasonConstStr(arg_9_0.actId, Activity123Enum.Const.StoryCoverIconUrl))

	arg_9_0._simageCover:LoadImage(var_9_0)

	arg_9_0._txttitleDesc.text = Season123Config.instance:getSeasonConstLangStr(arg_9_0.actId, Activity123Enum.Const.StoryCoverDesc)
	arg_9_0._txtcoverTitle.text = Season123Config.instance:getSeasonConstLangStr(arg_9_0.actId, Activity123Enum.Const.StoryCoverTitle)
end

function var_0_0.refreshDetailPageUI(arg_10_0)
	local var_10_0 = Season123Config.instance:getStoryConfig(arg_10_0.actId, arg_10_0.curPageIndex)

	arg_10_0._txtdetailTitle.text = GameUtil.setFirstStrSize(var_10_0.title, 80)

	local var_10_1 = Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", var_10_0.picture, arg_10_0.actId)

	arg_10_0._simagePolaroid:LoadImage(var_10_1)

	arg_10_0._txtdetailPageTitle.text = var_10_0.subTitle
	arg_10_0._txtAuthor.text = var_10_0.subContent

	gohelper.setActive(arg_10_0._txtAuthor.gameObject, not string.nilorempty(var_10_0.subContent))
	recthelper.setHeight(arg_10_0._scrollDesc.gameObject.transform, string.nilorempty(var_10_0.subContent) and 705 or 585)

	arg_10_0._txtdesc.text = var_10_0.content
end

function var_0_0.createCoverItem(arg_11_0)
	local var_11_0 = Season123Config.instance:getAllStoryCo(arg_11_0.actId)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = arg_11_0.coverItemTab[iter_11_0]

		if not var_11_1 then
			var_11_1 = {
				go = gohelper.clone(arg_11_0._gocoverItem, arg_11_0._gocoverContent, "cover" .. iter_11_0)
			}
			var_11_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1.go, Season123StoryCoverItem, {
				actId = arg_11_0.actId,
				storyId = iter_11_0,
				storyConfig = iter_11_1
			})
			arg_11_0.coverItemTab[iter_11_0] = var_11_1

			table.insert(arg_11_0.coverItemList, var_11_1)
		end

		var_11_1.item:refreshItem()

		arg_11_0.unlockStateTab[iter_11_0] = var_11_1.item.isUnlock

		gohelper.setActive(var_11_1.go, true)
	end
end

function var_0_0.refreshUnlockState(arg_12_0)
	local var_12_0 = PlayerPrefsHelper.getString(arg_12_0:getLocalKey(), "")
	local var_12_1 = {}

	if not string.nilorempty(var_12_0) then
		local var_12_2 = cjson.decode(var_12_0)

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			local var_12_3 = string.split(iter_12_1, "|")
			local var_12_4 = tonumber(var_12_3[1])
			local var_12_5 = arg_12_0:setStrToBool(var_12_3[2])

			arg_12_0.saveUnlockStateTab[var_12_4] = var_12_5
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.coverItemTab) do
		if GameUtil.getTabLen(arg_12_0.saveUnlockStateTab) == 0 then
			iter_12_3.item:refreshUnlockState(false)
		else
			local var_12_6 = arg_12_0.saveUnlockStateTab[iter_12_2]

			iter_12_3.item:refreshUnlockState(var_12_6)
		end
	end

	arg_12_0:saveUnlockState()
end

function var_0_0.getLocalKey(arg_13_0)
	return "Season123StoryUnlock" .. "#" .. tostring(arg_13_0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.saveUnlockState(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.unlockStateTab) do
		local var_14_1 = string.format("%s|%s", iter_14_0, iter_14_1)

		table.insert(var_14_0, var_14_1)
	end

	PlayerPrefsHelper.setString(arg_14_0:getLocalKey(), cjson.encode(var_14_0))
end

function var_0_0.setStrToBool(arg_15_0, arg_15_1)
	if string.nilorempty(arg_15_1) then
		return false
	elseif arg_15_1 == "true" then
		return true
	else
		return false
	end
end

function var_0_0.onCoverItemClick(arg_16_0, arg_16_1)
	arg_16_0.curPageIndex = arg_16_1.storyId

	arg_16_0:showSwitchPageAnim("todetail")
end

function var_0_0.showSwitchPageAnim(arg_17_0, arg_17_1)
	arg_17_0._animView.enabled = true

	arg_17_0._animView:Play(arg_17_1, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_screenplay_photo_close)
	UIBlockMgr.instance:startBlock("playSwitchPageAnim")
	TaskDispatcher.runDelay(arg_17_0.refreshPage, arg_17_0, 0.3)
end

function var_0_0.refreshPage(arg_18_0)
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	arg_18_0:refreshUI()
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:saveUnlockState()
	TaskDispatcher.cancelTask(arg_19_0.refreshPage, arg_19_0)
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	Season123Controller.instance:checkHasReadUnlockStory(arg_19_0.actId)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simageCover:UnLoadImage()
	arg_20_0._simagePolaroid:UnLoadImage()
end

return var_0_0
