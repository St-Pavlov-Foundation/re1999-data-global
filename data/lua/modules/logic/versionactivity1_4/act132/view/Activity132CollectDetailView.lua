module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailView", package.seeall)

local var_0_0 = class("Activity132CollectDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rightarrow")
	arg_1_0.btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_leftarrow")
	arg_1_0.simageRightBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_rightbg")
	arg_1_0.simageImg = gohelper.findChildImage(arg_1_0.viewGO, "Right/#simage_img")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/txt_Title")
	arg_1_0.txtTitleEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/txt_Title/txt_TitleEn")
	arg_1_0.goContentItem = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content/goContentItem")

	gohelper.setActive(arg_1_0.goContentItem, false)

	arg_1_0.contentItemList = {}
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "emptyBg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRightArrow, arg_2_0.onClickRightBtn, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLeftArrow, arg_2_0.onClickLeftBtn, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, arg_2_0.onContentUnlock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnRightArrow)
	arg_3_0:removeClickCb(arg_3_0.btnLeftArrow)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, arg_3_0.onContentUnlock, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.simageRightBg:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_rightbg.png")
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId
	arg_5_0.collectId = arg_5_0.viewParam.collectId
	arg_5_0.clueId = arg_5_0.viewParam.clueId

	arg_5_0:refreshUI()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId
	arg_6_0.collectId = arg_6_0.viewParam.collectId
	arg_6_0.clueId = arg_6_0.viewParam.clueId

	arg_6_0:refreshUI()
end

function var_0_0.onClickRightBtn(arg_7_0)
	local var_7_0 = Activity132Model.instance:getActMoById(arg_7_0.actId):getCollectMo(arg_7_0.collectId):getClueList()
	local var_7_1 = #var_7_0
	local var_7_2

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.clueId == arg_7_0.clueId then
			var_7_2 = iter_7_0

			break
		end
	end

	if var_7_2 then
		local var_7_3 = var_7_2 + 1

		if var_7_3 < 1 then
			var_7_3 = var_7_1
		end

		if var_7_1 < var_7_3 then
			var_7_3 = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, var_7_3)
	end
end

function var_0_0.onClickLeftBtn(arg_8_0)
	local var_8_0 = Activity132Model.instance:getActMoById(arg_8_0.actId):getCollectMo(arg_8_0.collectId):getClueList()
	local var_8_1 = #var_8_0
	local var_8_2

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1.clueId == arg_8_0.clueId then
			var_8_2 = iter_8_0

			break
		end
	end

	if var_8_2 then
		local var_8_3 = var_8_2 - 1

		if var_8_3 < 1 then
			var_8_3 = var_8_1
		end

		if var_8_1 < var_8_3 then
			var_8_3 = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, var_8_3)
	end
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = Activity132Config.instance:getCollectConfig(arg_9_0.actId, arg_9_0.collectId)
	local var_9_1 = Activity132Config.instance:getClueConfig(arg_9_0.actId, arg_9_0.clueId)
	local var_9_2 = var_9_0.name
	local var_9_3 = GameUtil.utf8sub(var_9_2, 1, 1)
	local var_9_4 = ""
	local var_9_5 = GameUtil.utf8len(var_9_2)

	if var_9_5 >= 2 then
		var_9_4 = GameUtil.utf8sub(var_9_2, 2, var_9_5 - 1)
	end

	local var_9_6 = string.format("<size=66>%s</size>%s", var_9_3, var_9_4)

	arg_9_0.txtTitle.text = var_9_6
	arg_9_0.txtTitleEn.text = var_9_0.nameEn

	UISpriteSetMgr.instance:setV1a4CollectSprite(arg_9_0.simageImg, var_9_1.smallBg, true)
	arg_9_0:refreshContents()
end

function var_0_0.refreshContents(arg_10_0)
	local var_10_0 = Activity132Model.instance:getActMoById(arg_10_0.actId)
	local var_10_1 = var_10_0:getCollectMo(arg_10_0.collectId):getClueMo(arg_10_0.clueId):getContentList()
	local var_10_2 = {}
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_4 = var_10_0:getContentState(iter_10_1.contentId)

		table.insert(var_10_2, iter_10_1)

		if var_10_4 == Activity132Enum.ContentState.CanUnlock then
			table.insert(var_10_3, iter_10_1.contentId)
		end
	end

	local var_10_5 = #arg_10_0.contentItemList
	local var_10_6 = #var_10_2

	for iter_10_2 = 1, math.max(var_10_5, var_10_6) do
		local var_10_7 = arg_10_0.contentItemList[iter_10_2]

		if not var_10_7 then
			var_10_7 = arg_10_0:createContentItem(iter_10_2)

			table.insert(arg_10_0.contentItemList, var_10_7)
		end

		var_10_7:setData(var_10_2[iter_10_2])
	end

	if #var_10_3 > 0 then
		Activity132Rpc.instance:sendAct132UnlockRequest(arg_10_0.actId, var_10_3)
	end
end

function var_0_0.createContentItem(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0.goContentItem, string.format("item%s", arg_11_1))

	return Activity132CollectDetailItem.New(var_11_0)
end

function var_0_0.onContentUnlock(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = {}

	for iter_12_0 = 1, #arg_12_1 do
		var_12_0[arg_12_1[iter_12_0]] = 1
	end

	for iter_12_1, iter_12_2 in ipairs(arg_12_0.contentItemList) do
		if iter_12_2.data and var_12_0[iter_12_2.data.contentId] then
			iter_12_2:playUnlock()
		end
	end
end

function var_0_0.onClickClose(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0.simageRightBg:UnLoadImage()
end

return var_0_0
