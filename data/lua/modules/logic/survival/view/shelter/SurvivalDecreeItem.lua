module("modules.logic.survival.view.shelter.SurvivalDecreeItem", package.seeall)

local var_0_0 = class("SurvivalDecreeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goHas = gohelper.findChild(arg_1_0.viewGO, "#go_Has")
	arg_1_0.goDescer = gohelper.findChild(arg_1_0.viewGO, "#go_Has/#scroll_Descr")
	arg_1_0.goDescItem = gohelper.findChild(arg_1_0.viewGO, "#go_Has/#scroll_Descr/Viewport/Content/goItem")
	arg_1_0.btnVote = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Has/#btn_Vote")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_Has/#btn_Finished")
	arg_1_0.goAdd = gohelper.findChild(arg_1_0.viewGO, "#go_Add")
	arg_1_0.btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Add/#btn_Add")
	arg_1_0.goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0.txtLocked = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Locked/#go_Tips/#txt_Tips")
	arg_1_0.goAnnouncement = gohelper.findChild(arg_1_0.viewGO, "#go_Announcement")
	arg_1_0.itemList = {}
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.tagList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAdd, arg_2_0.onClickAdd, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnVote, arg_2_0.onClickVote, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnAdd)
	arg_3_0:removeClickCb(arg_3_0.btnVote)
end

function var_0_0.onClickAdd(arg_4_0)
	if SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():isCurAllPolicyNotFinish() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDecreeNewTip, MsgBoxEnum.BoxType.Yes_No, function()
			SurvivalController.instance:openDecreeSelectView()
		end)
	else
		SurvivalController.instance:openDecreeSelectView()
	end
end

function var_0_0.onClickVote(arg_6_0)
	ViewMgr.instance:closeView(ViewName.SurvivalDecreeView)

	local var_6_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Explore)

	if var_6_0 then
		SurvivalMapHelper.instance:gotoBuilding(var_6_0.id)
	end
end

function var_0_0.updateItem(arg_7_0, arg_7_1)
	arg_7_0.decreeIndex = arg_7_1

	local var_7_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():getDecreeInfo(arg_7_1)

	arg_7_0:onUpdateMO(var_7_0)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1

	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	local var_9_0 = arg_9_0.mo and arg_9_0.mo:getCurStatus() or SurvivalEnum.ShelterDecreeStatus.Normal
	local var_9_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_9_2 = var_9_1:getAttr(SurvivalEnum.AttrType.DecreeNum) < arg_9_0.decreeIndex
	local var_9_3 = var_9_0 == SurvivalEnum.ShelterDecreeStatus.Normal
	local var_9_4 = not var_9_2 and not var_9_3
	local var_9_5 = not var_9_2 and var_9_3

	gohelper.setActive(arg_9_0.goHas, var_9_4)
	gohelper.setActive(arg_9_0.goAdd, var_9_5)
	gohelper.setActive(arg_9_0.goLocked, var_9_2)
	gohelper.setActive(arg_9_0.goAnnouncement, false)

	if var_9_4 then
		arg_9_0:refreshHas()
	end

	if var_9_2 then
		local var_9_6 = var_9_1:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)
		local var_9_7 = var_9_6 and var_9_6.baseCo
		local var_9_8 = var_9_7 and var_9_7.name or ""

		arg_9_0.txtLocked.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalbuildingmanageview_buildinglock_reason2"), var_9_8, arg_9_0.decreeIndex)
	end
end

function var_0_0.refreshHas(arg_10_0)
	local var_10_0 = arg_10_0.mo:getCurStatus() == SurvivalEnum.ShelterDecreeStatus.Finish

	gohelper.setActive(arg_10_0.btnVote, not var_10_0)
	gohelper.setActive(arg_10_0.goFinished, var_10_0)
	gohelper.setActive(arg_10_0.goAnnouncement, not var_10_0)

	local var_10_1 = arg_10_0.mo:getCurPolicyGroup():getPolicyList()

	for iter_10_0 = 1, math.max(#var_10_1, #arg_10_0.itemList) do
		local var_10_2 = arg_10_0:getItem(iter_10_0)

		arg_10_0:updateDescItem(var_10_2, var_10_1[iter_10_0], var_10_0)
	end

	arg_10_0:refreshTagList(var_10_1, var_10_0)
end

function var_0_0.getItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.itemList[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0.goDescItem, tostring(arg_11_1))

		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = var_11_1
		var_11_0.itemList = {}

		for iter_11_0 = 1, 2 do
			local var_11_2 = arg_11_0:getUserDataTb_()

			var_11_2.go = gohelper.findChild(var_11_1, string.format("#go_%s", iter_11_0))
			var_11_2.txtDesc = gohelper.findChildTextMesh(var_11_2.go, "#txt_Descr")
			var_11_2.txtNum = gohelper.findChildTextMesh(var_11_2.go, "#go_Like/#go_Like/#txt_Num")
			var_11_2.goLike = gohelper.findChild(var_11_2.go, "#go_Like")
			var_11_0.itemList[iter_11_0] = var_11_2
		end

		var_11_0.imageIcon = gohelper.findChildImage(arg_11_0.viewGO, string.format("#go_Has/Upper/image_Icon%s", arg_11_1))
		arg_11_0.itemList[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.updateDescItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	gohelper.setActive(arg_12_1.go, arg_12_2 ~= nil)

	if not arg_12_2 then
		return
	end

	local var_12_0 = SurvivalConfig.instance:getDecreeCo(arg_12_2.id)
	local var_12_1 = arg_12_2:isFinish() and 1 or 2

	for iter_12_0 = 1, 2 do
		local var_12_2 = arg_12_1.itemList[iter_12_0]

		gohelper.setActive(var_12_2.go, iter_12_0 == var_12_1)

		if iter_12_0 == var_12_1 then
			gohelper.setActive(var_12_2.goLike, not arg_12_3)

			var_12_2.txtNum.text = string.format("%s/%s", arg_12_2.currVoteNum, arg_12_2.needVoteNum)
			var_12_2.txtDesc.text = string.format(luaLang("SurvivalDecreeSelectItem_descItem_txtDesc"), var_12_0 and var_12_0.name or "", var_12_0 and var_12_0.desc or "")
		end
	end

	if arg_12_1.imageIcon and var_12_0 and var_12_0.icon then
		UISpriteSetMgr.instance:setSurvivalSprite(arg_12_1.imageIcon, var_12_0.icon, true)
	end
end

function var_0_0.playSwitchAnim(arg_13_0)
	if not arg_13_0.mo then
		return
	end

	if arg_13_0.mo:getCurStatus() == arg_13_0.mo:getRealStatus() then
		return
	end

	arg_13_0.anim:Play("switch", 0, 0)
	arg_13_0.mo:updateCurStatus()
	TaskDispatcher.runDelay(arg_13_0.refreshView, arg_13_0, 0.2)
	TaskDispatcher.runDelay(arg_13_0.onPlaySwitchAnimEnd, arg_13_0, 0.6)
end

function var_0_0.onPlaySwitchAnimEnd(arg_14_0)
	if PopupController.instance:isPause() then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_decision)
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function var_0_0.refreshTagList(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		return
	end

	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_2 = SurvivalConfig.instance:getDecreeCo(iter_15_1.id)
		local var_15_3 = string.splitToNumber(var_15_2 and var_15_2.tags, "#")

		if var_15_3 then
			for iter_15_2, iter_15_3 in ipairs(var_15_3) do
				var_15_1[iter_15_3] = 1
			end
		end
	end

	for iter_15_4, iter_15_5 in pairs(var_15_1) do
		table.insert(var_15_0, iter_15_4)
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_0 < arg_16_1
	end)

	local var_15_4 = 3

	for iter_15_6 = 1, var_15_4 do
		local var_15_5 = arg_15_0:getTagItem(iter_15_6)
		local var_15_6 = var_15_0[iter_15_6]
		local var_15_7 = lua_survival_tag.configDict[var_15_6]

		gohelper.setActive(var_15_5.go, var_15_7 ~= nil)

		if var_15_7 then
			var_15_5.txtType.text = var_15_7.name

			local var_15_8 = SurvivalEnum.ShelterTagColor[var_15_7.color]

			if var_15_8 then
				SLFramework.UGUI.GuiHelper.SetColor(var_15_5.imageType, var_15_8)
			end
		end
	end
end

function var_0_0.getTagItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.tagList[arg_17_1]

	if not var_17_0 then
		local var_17_1 = gohelper.findChild(arg_17_0.viewGO, string.format("#go_Has/#btn_Vote/#go_tag%s", arg_17_1))

		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = var_17_1
		var_17_0.imageType = gohelper.findChildImage(var_17_1, "#image_Type")
		var_17_0.txtType = gohelper.findChildTextMesh(var_17_1, "#txt_Type")
		arg_17_0.tagList[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refreshView, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.onPlaySwitchAnimEnd, arg_18_0)
end

return var_0_0
