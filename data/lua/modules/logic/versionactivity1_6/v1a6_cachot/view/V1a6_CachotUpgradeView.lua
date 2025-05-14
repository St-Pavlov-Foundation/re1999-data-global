module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeView", package.seeall)

local var_0_0 = class("V1a6_CachotUpgradeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "top/#simage_title")
	arg_1_0._gohope = gohelper.findChild(arg_1_0.viewGO, "top/#go_hope")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "top/#go_hope/bg/#go_progress")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "top/#go_hope/#txt_num1")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "top/#go_hope/#txt_num2")
	arg_1_0._goshop = gohelper.findChild(arg_1_0.viewGO, "top/#go_shop")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "top/#go_shop/#simage_icon")
	arg_1_0._txtshopnum = gohelper.findChildText(arg_1_0.viewGO, "top/#go_shop/#txt_shopnum")
	arg_1_0._gopresetcontent = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/#go_presetcontent")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal")
	arg_1_0._txtorder = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/#txt_order")
	arg_1_0._goqualityeffect1 = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect1")
	arg_1_0._imagequality1 = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality1")
	arg_1_0._goqualityeffect2 = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect2")
	arg_1_0._imagequality2 = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	arg_1_0._txtlevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1")
	arg_1_0._txtlevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level2")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch")
	arg_1_0._btnswitch2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch2")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details")
	arg_1_0._godetailitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details/#go_detailitem")
	arg_1_0._txtbreaklevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel1")
	arg_1_0._txtbreaklevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel2")
	arg_1_0._txttalentlevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel1")
	arg_1_0._txttalentlevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel2")
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "right/#go_full")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_upgrade")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#go_upgrade/#btn_upgrade")
	arg_1_0._txtupgrade = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_upgrade/#btn_upgrade/txt_upgrade")
	arg_1_0._txtupgradecost = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_upgrade/#txt_upgradecost")
	arg_1_0._gogiveup = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_giveup")
	arg_1_0._btngiveup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#go_giveup/#btn_giveup")
	arg_1_0._txtgiveupcost = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_giveup/#txt_giveupcost")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnswitch2:AddClickListener(arg_2_0._btnswitch2OnClick, arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0._btnupgradeOnClick, arg_2_0)
	arg_2_0._btngiveup:AddClickListener(arg_2_0._btngiveupOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnswitch2:RemoveClickListener()
	arg_3_0._btnupgrade:RemoveClickListener()
	arg_3_0._btngiveup:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_4_0)
	arg_4_0._detailAnimator:Play("close", 0, 0)
	arg_4_0:_showUpSwitch(false)
	TaskDispatcher.cancelTask(arg_4_0._hideDetail, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._hideDetail, arg_4_0, 0.16)
end

function var_0_0._hideDetail(arg_5_0)
	gohelper.setActive(arg_5_0._godetails, false)
end

function var_0_0._btngiveupOnClick(arg_6_0)
	if not arg_6_0._anyCanUpgrade then
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventId, arg_6_0.closeThis, arg_6_0)

		return
	end

	local function var_6_0()
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventId, arg_6_0.closeThis, arg_6_0)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox06, MsgBoxEnum.BoxType.Yes_No, var_6_0)
end

function var_0_0._btnswitch2OnClick(arg_8_0)
	gohelper.setActive(arg_8_0._godetails, true)
	arg_8_0:_showUpSwitch(true)
	arg_8_0._detailAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(arg_8_0._hideDetail, arg_8_0)
end

function var_0_0._showUpSwitch(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._btnswitch, arg_9_1)
	gohelper.setActive(arg_9_0._btnswitch2, not arg_9_1)
end

function var_0_0._btnupgradeOnClick(arg_10_0)
	if not arg_10_0._nextConfig then
		GameFacade.showToast(ToastEnum.V1a6CachotToast06)

		return
	end

	if arg_10_0._nextConfig and arg_10_0._nextConfig.cost > arg_10_0._rogueInfo.currency then
		GameFacade.showToast(ToastEnum.V1a6CachotToast05)

		return
	end

	local var_10_0 = arg_10_0._selectedTeamItem:getSeatIndex()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, arg_10_0.viewParam.eventId, var_10_0, arg_10_0._onSelectEnd, arg_10_0)
end

function var_0_0._onSelectEnd(arg_11_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnSeatUpgradeSuccess)
end

function var_0_0._initPresetItemList(arg_12_0)
	if arg_12_0._presetItemList then
		return
	end

	arg_12_0._presetItemList = arg_12_0:getUserDataTb_()

	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes[1]

	for iter_12_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_12_1 = arg_12_0:getResInst(var_12_0, arg_12_0._gopresetcontent, "item" .. tostring(iter_12_0))
		local var_12_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, V1a6_CachotTeamItem)

		arg_12_0._presetItemList[iter_12_0] = var_12_2

		var_12_2:setSelectEnable(true)
	end
end

function var_0_0._updatePresetItemList(arg_13_0)
	arg_13_0._anyCanUpgrade = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._presetItemList) do
		local var_13_0 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_13_0)
		local var_13_1 = V1a6_CachotTeamModel.instance:getSeatLevel(iter_13_0)

		V1a6_CachotTeamModel.instance:setSeatInfo(iter_13_0, var_13_1, var_13_0)
		iter_13_1:onUpdateMO(var_13_0)

		local var_13_2 = var_13_1 + 1
		local var_13_3 = lua_rogue_field.configDict[var_13_2]

		if var_13_3 then
			if var_13_3.cost > arg_13_0._rogueInfo.currency then
				iter_13_1:setCost(string.format("<color=#D97373>-%s</color>", var_13_3.cost))
			else
				iter_13_1:setCost("-" .. var_13_3.cost)

				arg_13_0._anyCanUpgrade = true
			end
		else
			iter_13_1:setCost()
		end
	end
end

function var_0_0._selectItem(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._presetItemList) do
		local var_14_0 = arg_14_1 and iter_14_0 == arg_14_1
		local var_14_1 = arg_14_2 and iter_14_1:getMo() == arg_14_2
		local var_14_2 = var_14_0 or var_14_1

		iter_14_1:setSelected(var_14_2)

		if var_14_2 then
			arg_14_0._selectedIndex = iter_14_0

			arg_14_0:_showSeatInfo(iter_14_1)
		end
	end
end

function var_0_0._setQuality(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0[arg_15_4]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		arg_15_0[arg_15_4] = var_15_0

		local var_15_1 = arg_15_1.transform
		local var_15_2 = var_15_1.childCount

		for iter_15_0 = 1, var_15_2 do
			local var_15_3 = var_15_1:GetChild(iter_15_0 - 1)

			var_15_0[var_15_3.name] = var_15_3

			local var_15_4 = var_15_3:GetComponentsInChildren(gohelper.Type_Image, true)

			for iter_15_1 = 0, var_15_4.Length - 1 do
				var_15_4[iter_15_1].maskable = true
			end
		end
	end

	local var_15_5 = "effect_0" .. arg_15_3

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		gohelper.setActive(iter_15_3, iter_15_2 == var_15_5)
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_15_2, "v1a6_cachot_quality_0" .. arg_15_3)
end

function var_0_0._showSeatInfo(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._gonormal, false)
	gohelper.setActive(arg_16_0._gofull, false)

	local var_16_0 = arg_16_1:getSeatIndex()

	arg_16_0._selectedTeamItem = arg_16_1
	arg_16_0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(var_16_0))

	local var_16_1 = V1a6_CachotTeamModel.instance:getSeatLevel(var_16_0)
	local var_16_2 = var_16_1 + 1
	local var_16_3 = lua_rogue_field.configDict[var_16_2]

	arg_16_0._nextConfig = var_16_3

	gohelper.setActive(arg_16_0._txtupgradecost, var_16_3)
	ZProj.UGUIHelper.SetGrayscale(arg_16_0._btnupgrade.gameObject, var_16_3 == nil)
	ZProj.UGUIHelper.SetGrayscale(arg_16_0._txtupgrade.gameObject, var_16_3 == nil)

	if not var_16_3 then
		gohelper.setActive(arg_16_0._gofull, true)

		return
	end

	gohelper.setActive(arg_16_0._gonormal, true)

	local var_16_4 = lua_rogue_field.configDict[var_16_1]

	arg_16_0:_setQuality(arg_16_0._goqualityeffect1, arg_16_0._imagequality1, var_16_1, "effectListKey1")
	arg_16_0:_setQuality(arg_16_0._goqualityeffect2, arg_16_0._imagequality2, var_16_2, "effectListKey2")

	arg_16_0._txtbreaklevel1.text = "Lv." .. var_16_4.equipLevel
	arg_16_0._txtbreaklevel2.text = "Lv." .. var_16_3.equipLevel
	arg_16_0._txttalentlevel1.text = "Lv." .. var_16_4.talentLevel
	arg_16_0._txttalentlevel2.text = "Lv." .. var_16_3.talentLevel

	local var_16_5 = arg_16_1:getHeroMo()
	local var_16_6 = 6

	if var_16_5 then
		var_16_6 = CharacterEnum.Star[var_16_5.config.rare]
	end

	arg_16_0._roleStarNum.text = tostring(var_16_6)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._roleStarList) do
		gohelper.setActive(iter_16_1, iter_16_0 <= var_16_6)
	end

	local var_16_7 = arg_16_0:_getLevelKey(var_16_6)

	arg_16_0:_showDetailLevel(var_16_4[var_16_7], arg_16_0._txtlevel1, arg_16_0._rankList1)
	arg_16_0:_showDetailLevel(var_16_3[var_16_7], arg_16_0._txtlevel2, arg_16_0._rankList2)

	for iter_16_2, iter_16_3 in ipairs(arg_16_0._detailItemList) do
		local var_16_8 = arg_16_0:_getLevelKey(iter_16_3.starNum)

		arg_16_0:_updateDetailItem(iter_16_3, var_16_4, var_16_3, var_16_8)
	end

	if var_16_3.cost > arg_16_0._rogueInfo.currency then
		arg_16_0._txtupgradecost.text = string.format("<color=#D97373>-%s</color>", var_16_3.cost)
	else
		arg_16_0._txtupgradecost.text = string.format("<color=#E6E5E1>-%s</color>", var_16_3.cost)
	end
end

function var_0_0._getLevelKey(arg_17_0, arg_17_1)
	if arg_17_1 >= 5 then
		return "level" .. arg_17_1
	else
		return "level4"
	end
end

function var_0_0._updateDetailItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0:_showDetailLevel(arg_18_2[arg_18_4], arg_18_1.lv1, arg_18_1._rankList1)
	arg_18_0:_showDetailLevel(arg_18_3[arg_18_4], arg_18_1.lv2, arg_18_1._rankList2)
end

function var_0_0._showDetailLevel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1 = HeroConfig.instance:getShowLevel(arg_19_1)

	arg_19_2.text = "Lv." .. var_19_0

	for iter_19_0, iter_19_1 in ipairs(arg_19_3) do
		local var_19_2 = iter_19_0 == var_19_1 - 1

		gohelper.setActive(iter_19_1, var_19_2)
	end
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0:_initRoleLevelInfo()
	arg_20_0:_initDetailItemList()
	gohelper.setActive(arg_20_0._txtgiveupcost, false)

	arg_20_0._animator = arg_20_0.viewGO:GetComponent("Animator")
	arg_20_0._detailAnimator = arg_20_0._godetails:GetComponent("Animator")
end

function var_0_0._initRoleLevelInfo(arg_21_0)
	arg_21_0._roleStarList = arg_21_0:getUserDataTb_()
	arg_21_0._roleStarNum = gohelper.findChildText(arg_21_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/#txt_num")

	local var_21_0 = gohelper.findChild(arg_21_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/rare")
	local var_21_1 = 1

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = gohelper.findChild(var_21_0, "go_rare" .. iter_21_0)

		arg_21_0._roleStarList[iter_21_0] = var_21_2
	end

	arg_21_0._rankList1 = arg_21_0:getUserDataTb_()
	arg_21_0._rankList2 = arg_21_0:getUserDataTb_()

	for iter_21_1 = 1, 3 do
		local var_21_3 = gohelper.findChild(arg_21_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1/rankobj/rank" .. iter_21_1)

		table.insert(arg_21_0._rankList1, var_21_3)

		local var_21_4 = gohelper.findChild(arg_21_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/rankobj/rank" .. iter_21_1)

		table.insert(arg_21_0._rankList2, var_21_4)
	end
end

function var_0_0._initDetailItemList(arg_22_0)
	arg_22_0._detailItemList = arg_22_0:getUserDataTb_()

	local var_22_0 = {}

	for iter_22_0 = 6, 1, -1 do
		table.insert(var_22_0, iter_22_0)
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0._initDetailItem, var_22_0, arg_22_0._godetails, arg_22_0._godetailitem)
end

function var_0_0._initDetailItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:getUserDataTb_()

	var_23_0.starNum = arg_23_2
	var_23_0.lv1 = gohelper.findChildText(arg_23_1, "txt_level1")
	var_23_0.lv2 = gohelper.findChildText(arg_23_1, "txt_level2")
	var_23_0.lvnum = gohelper.findChildText(arg_23_1, "#txt_num")
	var_23_0.lvnum.text = tostring(arg_23_2)
	var_23_0._rankList1 = arg_23_0:getUserDataTb_()
	var_23_0._rankList2 = arg_23_0:getUserDataTb_()

	for iter_23_0 = 1, 3 do
		local var_23_1 = gohelper.findChild(arg_23_1, "txt_level1/rankobj/rank" .. iter_23_0)

		table.insert(var_23_0._rankList1, var_23_1)

		local var_23_2 = gohelper.findChild(arg_23_1, "rankobj/rank" .. iter_23_0)

		table.insert(var_23_0._rankList2, var_23_2)
	end

	local var_23_3 = 1

	for iter_23_1 = 1, var_23_3 do
		local var_23_4 = gohelper.findChild(arg_23_1, "rare/go_rare" .. iter_23_1)

		gohelper.setActive(var_23_4, iter_23_1 <= arg_23_2)
	end

	gohelper.setActive(arg_23_1, true)

	arg_23_0._detailItemList[arg_23_3] = var_23_0

	if arg_23_3 == 6 then
		gohelper.setActive(arg_23_1, false)
	end
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	V1a6_CachotTeamModel.instance:clearSeatInfos()
	arg_24_0:_initPresetItemList()
	arg_24_0:_updatePresetItemList()
	arg_24_0:_selectItem(1)
	arg_24_0:_showUpSwitch(false)
	arg_24_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, arg_24_0._onClickTeamItem, arg_24_0)
	arg_24_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnSeatUpgradeSuccess, arg_24_0._onSeatUpgradeSuccess, arg_24_0)
	arg_24_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_24_0._onCloseView, arg_24_0)
	arg_24_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_24_0._onOpenView, arg_24_0)
end

function var_0_0._onOpenView(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.V1a6_CachotUpgradeResultView then
		arg_25_0._animator.enabled = true

		arg_25_0._animator:Play("close", 0, 0)
	end
end

function var_0_0._onCloseView(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.V1a6_CachotUpgradeResultView then
		arg_26_0._animator.enabled = true

		arg_26_0._animator:Play("back", 0, 0)
		arg_26_0:_updatePresetItemList()
		arg_26_0:_selectItem(arg_26_0._selectedIndex)
	end
end

function var_0_0._onSeatUpgradeSuccess(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._presetItemList) do
		local var_27_0 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_27_0)
		local var_27_1 = V1a6_CachotTeamModel.instance:getSeatLevel(iter_27_0)

		V1a6_CachotTeamModel.instance:setSeatInfo(iter_27_0, var_27_1, var_27_0)
	end

	V1a6_CachotController.instance:openV1a6_CachotUpgradeResultView({
		teamItemMo = arg_27_0._selectedTeamItem:getMo(),
		seatIndex = arg_27_0._selectedTeamItem:getSeatIndex()
	})
end

function var_0_0._onClickTeamItem(arg_28_0, arg_28_1)
	arg_28_0._animator.enabled = true

	arg_28_0._animator:Play("switch", 0, 0)
	arg_28_0:_showUpSwitch(false)
	gohelper.setActive(arg_28_0._godetails, false)
	TaskDispatcher.cancelTask(arg_28_0._hideDetail, arg_28_0)
	arg_28_0:_selectItem(nil, arg_28_1)
end

function var_0_0.onClose(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._hideDetail, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	return
end

return var_0_0
