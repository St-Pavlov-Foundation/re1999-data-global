module("modules.logic.survival.view.shelter.ShelterRecruitView", package.seeall)

local var_0_0 = class("ShelterRecruitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goDemand = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand")
	arg_1_0.goTagItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#scroll_List/Viewport/Content/#go_item")

	gohelper.setActive(arg_1_0.goTagItem, false)

	arg_1_0.txtDemandTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/txt_Tips")
	arg_1_0.goAnnounce = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce")
	arg_1_0.btnRecuit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/#btn_Recruit")
	arg_1_0.txtRecuitCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost")
	arg_1_0.imageRecuitCost = gohelper.findChildImage(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost/#image_Currency")
	arg_1_0.btnRefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/#btn_RefreshBtn")
	arg_1_0.goStandby = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#go_Standby")
	arg_1_0.txtRefreshCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RefreshCost")
	arg_1_0.goMember = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Member")
	arg_1_0.goNpcItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Member/#scroll_List/Viewport/#go_content/#go_item")

	gohelper.setActive(arg_1_0.goNpcItem, false)

	arg_1_0.btnMemberRecuit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Member/#btn_Recruit")
	arg_1_0.btnCloseRecruit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Member/#btn_CloseRecruit")
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")
	arg_1_0.tagList = {}
	arg_1_0.npcList = {}
	arg_1_0.selectTags = {}
	arg_1_0.selectNpcId = 0
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRecuit, arg_2_0.onClickBtnRecuit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRefresh, arg_2_0.onClickBtnRefresh, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMemberRecuit, arg_2_0.onClickBtnMemberRecuit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCloseRecruit, arg_2_0.onClickBtnCloseRecruit, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, arg_2_0.onRecruitDataUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, arg_2_0.onRecruitRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnRecuit)
	arg_3_0:removeClickCb(arg_3_0.btnRefresh)
	arg_3_0:removeClickCb(arg_3_0.btnMemberRecuit)
	arg_3_0:removeClickCb(arg_3_0.btnCloseRecruit)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, arg_3_0.onRecruitDataUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, arg_3_0.onRecruitRefresh, arg_3_0)
end

function var_0_0.onClickClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onRecruitRefresh(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tagList) do
		iter_5_1.animator:Play(UIAnimationName.Switch, 0, 0)
	end

	UIBlockHelper.instance:startBlock(arg_5_0.viewName, 0.167, arg_5_0.viewName)
	TaskDispatcher.runDelay(arg_5_0.refreshView, arg_5_0, 0.167)
end

function var_0_0.onShelterBagUpdate(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onClickBtnRecuit(arg_7_0)
	if not arg_7_0.recruitInfo or not arg_7_0.recruitInfo:isCanRecruit() then
		return
	end

	local var_7_0 = arg_7_0.recruitInfo.config

	if not var_7_0 then
		return
	end

	local var_7_1, var_7_2, var_7_3, var_7_4 = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_7_0.cost)

	if not var_7_1 then
		local var_7_5 = lua_survival_item.configDict[var_7_2]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_7_5.name)

		return
	end

	local var_7_6 = arg_7_0.recruitInfo.selectCount
	local var_7_7 = tabletool.len(arg_7_0.selectTags)

	if var_7_7 == 0 or var_7_7 ~= var_7_6 then
		GameFacade.showToast(ToastEnum.ShelterRecruitSelectNotEnough)

		return
	end

	local var_7_8 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.selectTags) do
		table.insert(var_7_8, iter_7_0)
	end

	SurvivalWeekRpc.instance:sendSurvivalPublishRecruitTagRequest(var_7_8)
end

function var_0_0.onClickBtnRefresh(arg_8_0)
	if not arg_8_0.recruitInfo then
		return
	end

	if arg_8_0.recruitInfo.canRefreshTimes == 0 then
		local var_8_0 = arg_8_0.recruitInfo.config
		local var_8_1, var_8_2 = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_8_0 and var_8_0.refreshCost)

		if not var_8_1 then
			local var_8_3 = lua_survival_item.configDict[var_8_2]

			GameFacade.showToast(ToastEnum.DiamondBuy, var_8_3.name)

			return
		end
	end

	SurvivalWeekRpc.instance:sendSurvivalRefreshRecruitTagRequest()
end

function var_0_0.onClickBtnMemberRecuit(arg_9_0)
	if arg_9_0.selectNpcId == nil or arg_9_0.selectNpcId == 0 then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRecruitNpcRequest(arg_9_0.selectNpcId, arg_9_0.onSurvivalRecruitNpc, arg_9_0)
end

function var_0_0.onSurvivalRecruitNpc(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	local var_10_0 = SurvivalBagItemMo.New()

	var_10_0:init({
		count = 1,
		id = arg_10_0.selectNpcId
	})

	var_10_0.source = SurvivalEnum.ItemSource.Drop

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
		items = {
			var_10_0
		}
	})
	arg_10_0:closeThis()
end

function var_0_0.onClickBtnCloseRecruit(arg_11_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalAbandonRecruitNpc, MsgBoxEnum.BoxType.Yes_No, arg_11_0._sendAbandonRecruitNpc, nil, nil, arg_11_0, nil, nil)
end

function var_0_0._sendAbandonRecruitNpc(arg_12_0)
	SurvivalWeekRpc.instance:sendSurvivalAbandonRecruitNpcRequest()
	arg_12_0:closeThis()
end

function var_0_0.onClickTag(arg_13_0, arg_13_1)
	if not arg_13_0.recruitInfo then
		return
	end

	local var_13_0 = arg_13_1.tagId

	if var_13_0 == nil or var_13_0 == 0 then
		return
	end

	if not arg_13_0.recruitInfo:isCanRecruit() then
		return
	end

	if arg_13_0.selectTags[var_13_0] ~= nil then
		arg_13_0.selectTags[var_13_0] = nil
	else
		if arg_13_0.recruitInfo.selectCount == tabletool.len(arg_13_0.selectTags) then
			return
		end

		arg_13_0.selectTags[var_13_0] = true
	end

	arg_13_0:refreshTagList()
end

function var_0_0.onClickNpc(arg_14_0, arg_14_1)
	if not arg_14_1.data then
		return
	end

	local var_14_0 = arg_14_1.data.npcId

	if var_14_0 == arg_14_0.selectNpcId then
		arg_14_0.selectNpcId = 0
	else
		arg_14_0.selectNpcId = var_14_0
	end

	arg_14_0:refreshNpcList()
end

function var_0_0.onRecruitDataUpdate(arg_15_0)
	arg_15_0:refreshView()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:refreshView()
end

function var_0_0.refreshView(arg_17_0)
	arg_17_0.recruitInfo = SurvivalShelterModel.instance:getWeekInfo():getRecruitInfo()

	if not arg_17_0.recruitInfo then
		return
	end

	local var_17_0 = arg_17_0.recruitInfo:isCanSelectNpc()

	gohelper.setActive(arg_17_0.goDemand, not var_17_0)
	gohelper.setActive(arg_17_0.goMember, var_17_0)

	if var_17_0 then
		arg_17_0:refreshMemberView()
	else
		arg_17_0:refreshDemandView()
	end
end

function var_0_0.refreshDemandView(arg_18_0)
	if arg_18_0.recruitInfo:isCanRecruit() then
		gohelper.setActive(arg_18_0.goStandby, false)
		gohelper.setActive(arg_18_0.goAnnounce, true)
		arg_18_0:refreshDemandButton()
	else
		gohelper.setActive(arg_18_0.goStandby, true)
		gohelper.setActive(arg_18_0.goAnnounce, false)
	end

	local var_18_0 = arg_18_0.recruitInfo.selectedTags

	arg_18_0.selectTags = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		arg_18_0.selectTags[iter_18_1] = true
	end

	arg_18_0:refreshTagList()
end

function var_0_0.refreshDemandButton(arg_19_0)
	local var_19_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_19_1 = arg_19_0.recruitInfo.config
	local var_19_2 = arg_19_0.recruitInfo.canRefreshTimes > 0

	gohelper.setActive(arg_19_0.txtRefreshCost, not var_19_2)

	if not var_19_2 then
		local var_19_3, var_19_4, var_19_5, var_19_6 = var_19_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_19_1 and var_19_1.refreshCost)

		if var_19_3 then
			arg_19_0.txtRefreshCost.text = tostring(var_19_5)
		else
			arg_19_0.txtRefreshCost.text = string.format("<color=#D74242>%s</color>", var_19_5)
		end
	end

	local var_19_7, var_19_8, var_19_9, var_19_10 = var_19_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_19_1 and var_19_1.cost)

	if var_19_7 then
		arg_19_0.txtRecuitCost.text = tostring(var_19_9)
	else
		arg_19_0.txtRecuitCost.text = string.format("<color=#D74242>%s</color>", var_19_9)
	end
end

function var_0_0.refreshTagList(arg_20_0)
	local var_20_0 = arg_20_0.recruitInfo.selectCount
	local var_20_1 = tabletool.len(arg_20_0.selectTags)
	local var_20_2 = arg_20_0.recruitInfo:isInRecruit()
	local var_20_3 = var_20_0 == var_20_1 or var_20_2
	local var_20_4 = arg_20_0.recruitInfo.tags

	for iter_20_0 = 1, math.max(#var_20_4, #arg_20_0.tagList) do
		local var_20_5 = arg_20_0:getTagItem(iter_20_0)

		arg_20_0:refreshTagItem(var_20_5, var_20_4[iter_20_0], var_20_3)
	end

	if var_20_2 then
		arg_20_0.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_menber_tips"), var_20_1, var_20_0)
	else
		arg_20_0.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_demand_tips"), var_20_1, var_20_0)

		ZProj.UGUIHelper.SetGrayscale(arg_20_0.btnRecuit.gameObject, not var_20_3)
	end
end

function var_0_0.getTagItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.tagList[arg_21_1]

	if not var_21_0 then
		var_21_0 = arg_21_0:getUserDataTb_()
		var_21_0.go = gohelper.cloneInPlace(arg_21_0.goTagItem, tostring(arg_21_1))
		var_21_0.imageBg = gohelper.findChildImage(var_21_0.go, "#image_BG")
		var_21_0.goSelect = gohelper.findChild(var_21_0.go, "#go_Selected")
		var_21_0.txtTile = gohelper.findChildTextMesh(var_21_0.go, "#txt_Title")
		var_21_0.txtDesc = gohelper.findChildTextMesh(var_21_0.go, "#txt_Descr")
		var_21_0.canvasGroup = gohelper.onceAddComponent(var_21_0.go, typeof(UnityEngine.CanvasGroup))
		var_21_0.goMask = gohelper.findChild(var_21_0.go, "mask")
		var_21_0.btn = gohelper.findChildButtonWithAudio(var_21_0.go, "Click")

		var_21_0.btn:AddClickListener(arg_21_0.onClickTag, arg_21_0, var_21_0)

		var_21_0.animator = var_21_0.go:GetComponent(gohelper.Type_Animator)
		arg_21_0.tagList[arg_21_1] = var_21_0
	end

	return var_21_0
end

function var_0_0.refreshTagItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_1.tagId = arg_22_2

	if not arg_22_2 then
		gohelper.setActive(arg_22_1.go, false)

		return
	end

	gohelper.setActive(arg_22_1.go, true)

	local var_22_0 = SurvivalConfig.instance:getTagCo(arg_22_2)

	if not var_22_0 then
		return
	end

	arg_22_1.txtTile.text = var_22_0.name
	arg_22_1.txtDesc.text = var_22_0.desc

	local var_22_1 = arg_22_0.selectTags[arg_22_2]

	gohelper.setActive(arg_22_1.goSelect, var_22_1)

	local var_22_2 = arg_22_3 and not var_22_1 and 0.5 or 1

	arg_22_1.canvasGroup.alpha = var_22_2

	gohelper.setActive(arg_22_1.goMask, var_22_2 ~= 1)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_22_1.imageBg, string.format("survivalshelterrecruit_charbg%s", var_22_0.color))
end

function var_0_0.refreshMemberView(arg_23_0)
	arg_23_0.selectNpcId = 0

	arg_23_0:refreshNpcList()
end

function var_0_0.refreshNpcList(arg_24_0)
	local var_24_0 = arg_24_0.recruitInfo.goodList

	for iter_24_0 = 1, math.max(#var_24_0, #arg_24_0.npcList) do
		local var_24_1 = arg_24_0:getNpcItem(iter_24_0)

		arg_24_0:refreshNpcItem(var_24_1, var_24_0[iter_24_0])
	end

	local var_24_2 = arg_24_0.selectNpcId ~= nil and arg_24_0.selectNpcId ~= 0

	ZProj.UGUIHelper.SetGrayscale(arg_24_0.btnMemberRecuit.gameObject, not var_24_2)
end

function var_0_0.getNpcItem(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.npcList[arg_25_1]

	if not var_25_0 then
		var_25_0 = arg_25_0:getUserDataTb_()
		var_25_0.go = gohelper.cloneInPlace(arg_25_0.goNpcItem, tostring(arg_25_1))
		var_25_0.imageChess = gohelper.findChildSingleImage(var_25_0.go, "#image_Chess")
		var_25_0.txtName = gohelper.findChildTextMesh(var_25_0.go, "#txt_PartnerName")
		var_25_0.goSelect = gohelper.findChild(var_25_0.go, "#go_Selected")
		var_25_0.goAttrItem = gohelper.findChild(var_25_0.go, "Scroll View/Viewport/#go_content/#go_Attr")

		gohelper.setActive(var_25_0.goAttrItem, false)

		var_25_0.attrItemList = {}
		var_25_0.btn = gohelper.findChildButtonWithAudio(var_25_0.go, "")

		var_25_0.btn:AddClickListener(arg_25_0.onClickNpc, arg_25_0, var_25_0)

		arg_25_0.npcList[arg_25_1] = var_25_0
	end

	return var_25_0
end

function var_0_0.refreshNpcItem(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1.data = arg_26_2

	if not arg_26_2 then
		gohelper.setActive(arg_26_1.go, false)

		return
	end

	gohelper.setActive(arg_26_1.go, true)

	local var_26_0 = arg_26_2.npcId
	local var_26_1 = SurvivalConfig.instance:getNpcConfig(var_26_0)

	gohelper.setActive(arg_26_1.goSelect, var_26_0 == arg_26_0.selectNpcId)

	if not var_26_1 then
		return
	end

	arg_26_1.txtName.text = var_26_1.name

	SurvivalUnitIconHelper.instance:setNpcIcon(arg_26_1.imageChess, var_26_1.headIcon)

	local var_26_2, var_26_3 = SurvivalConfig.instance:getNpcConfigTag(var_26_0)

	for iter_26_0 = 1, math.max(#var_26_3, #arg_26_1.attrItemList) do
		local var_26_4 = arg_26_0:getNpcAttrItem(arg_26_1, iter_26_0)

		arg_26_0:refreshNpcAttrItem(var_26_4, var_26_3[iter_26_0])
	end
end

function var_0_0.getNpcAttrItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.attrItemList[arg_27_2]

	if not var_27_0 then
		var_27_0 = arg_27_0:getUserDataTb_()
		var_27_0.go = gohelper.cloneInPlace(arg_27_1.goAttrItem, tostring(arg_27_2))
		var_27_0.txtTitle = gohelper.findChildTextMesh(var_27_0.go, "image_TitleBG/#txt_Title")
		var_27_0.txtDesc = gohelper.findChildTextMesh(var_27_0.go, "")
		var_27_0.imgTitle = gohelper.findChildImage(var_27_0.go, "image_TitleBG")
		arg_27_1.attrItemList[arg_27_2] = var_27_0
	end

	return var_27_0
end

function var_0_0.refreshNpcAttrItem(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_2 then
		gohelper.setActive(arg_28_1.go, false)

		return
	end

	gohelper.setActive(arg_28_1.go, true)

	local var_28_0 = lua_survival_tag.configDict[arg_28_2]

	arg_28_1.txtTitle.text = var_28_0.name
	arg_28_1.txtDesc.text = var_28_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(arg_28_1.imgTitle, string.format("survivalpartnerteam_attrbg%s", var_28_0.color))
end

function var_0_0.onDestroyView(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.tagList) do
		iter_29_1.btn:RemoveClickListener()
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_0.npcList) do
		iter_29_3.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_29_0.refreshView, arg_29_0)
end

return var_0_0
