module("modules.logic.versionactivity2_4.pinball.view.PinballTalentView", package.seeall)

local var_0_0 = class("PinballTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._fullclick = gohelper.findChildClick(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._txttalentname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_detail/#txt_talentname")
	arg_1_0._txttalentdec = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_detail/#txt_talentdec")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_cancel")
	arg_1_0._btnlight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_light")
	arg_1_0._golightgrey = gohelper.findChild(arg_1_0.viewGO, "#go_detail/#btn_light/grey")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "#go_detail/#go_currency/go_item")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._gotabitem = gohelper.findChild(arg_1_0.viewGO, "#go_btn/#btn_building")
	arg_1_0._talentitem = gohelper.findChild(arg_1_0.viewGO, "#go_talentree/#go_talenitem")
	arg_1_0._talentroot = gohelper.findChild(arg_1_0.viewGO, "#go_talentree/#go_talengroup")
	arg_1_0._topCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._treeAnim = gohelper.findChildAnim(arg_1_0.viewGO, "#go_talentree")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._fullclick:AddClickListener(arg_2_0._cancelSelect, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._cancelSelect, arg_2_0)
	arg_2_0._btnlight:AddClickListener(arg_2_0._learnTalent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._fullclick:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnlight:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._talentitem, false)
	arg_4_0:initNodeAndLine()
	arg_4_0:initTab()
	arg_4_0:createCurrencyItem()
end

function var_0_0.initTab(arg_5_0)
	local var_5_0 = PinballModel.instance:getAllTalentBuildingId()
	local var_5_1 = {}
	local var_5_2

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_3 = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][iter_5_1][1]
		local var_5_4 = var_5_3.effect
		local var_5_5 = 1
		local var_5_6 = GameUtil.splitString2(var_5_4, true) or {}

		for iter_5_2, iter_5_3 in pairs(var_5_6) do
			if iter_5_3[1] == PinballEnum.BuildingEffectType.UnlockTalent then
				var_5_5 = iter_5_3[2]

				break
			end
		end

		local var_5_7 = {
			co = var_5_3,
			type = var_5_5
		}

		table.insert(var_5_1, var_5_7)

		if arg_5_0.viewParam.info.baseCo == var_5_3 then
			var_5_2 = var_5_7
		end
	end

	arg_5_0._tabs = {}
	var_5_2 = var_5_2 or var_5_1[1]

	gohelper.CreateObjList(arg_5_0, arg_5_0._createTab, var_5_1, nil, arg_5_0._gotabitem, PinballTalentTabItem)
	arg_5_0:_onTabClick(var_5_2)
end

function var_0_0._createTab(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._tabs[arg_6_3] = arg_6_1

	arg_6_1:setData(arg_6_2)
	arg_6_1:setClickCall(arg_6_0._onTabClick, arg_6_0)
end

function var_0_0._onTabClick(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0._selectData then
		arg_7_0._selectData = arg_7_1

		for iter_7_0, iter_7_1 in pairs(arg_7_0._tabs) do
			iter_7_1:setSelectData(arg_7_1)
		end

		arg_7_0:initTalent()
		arg_7_0:_refreshLineStatu()
		arg_7_0:_cancelSelect()
		arg_7_0._treeAnim:Play("open", 0, 0)
	end
end

function var_0_0.initNodeAndLine(arg_8_0)
	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "#go_talentree/frame").transform
	local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "#go_talentree/#go_talengroup").transform

	arg_8_0._lines = {}
	arg_8_0._nodes = {}

	for iter_8_0 = 0, var_8_0.childCount - 1 do
		local var_8_2 = var_8_0:GetChild(iter_8_0)
		local var_8_3 = var_8_2.name
		local var_8_4 = string.match(var_8_3, "^line(.+)$")

		if var_8_4 then
			local var_8_5 = string.split(var_8_4, "_") or {}

			for iter_8_1, iter_8_2 in ipairs(var_8_5) do
				if not arg_8_0._lines[iter_8_2] then
					arg_8_0._lines[iter_8_2] = arg_8_0:getUserDataTb_()
				end

				local var_8_6 = gohelper.findChildImage(var_8_2.gameObject, "")

				table.insert(arg_8_0._lines[iter_8_2], var_8_6)
			end
		end
	end

	for iter_8_3 = 0, var_8_1.childCount - 1 do
		local var_8_7 = var_8_1:GetChild(iter_8_3)
		local var_8_8 = var_8_7.name
		local var_8_9 = gohelper.clone(arg_8_0._talentitem, var_8_7.gameObject)

		gohelper.setActive(var_8_9, true)

		local var_8_10 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_9, PinballTalentItem)

		arg_8_0._nodes[var_8_8] = var_8_10

		arg_8_0:addClickCb(gohelper.getClick(var_8_9), arg_8_0._selectTalent, arg_8_0, var_8_8)
	end
end

function var_0_0.initTalent(arg_9_0)
	local var_9_0 = PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, arg_9_0._selectData.type)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if arg_9_0._nodes[iter_9_1.point] then
			arg_9_0._nodes[iter_9_1.point]:setData(iter_9_1, arg_9_0._selectData.co)
		end
	end

	arg_9_0:_refreshLineStatu()
end

function var_0_0._refreshLineStatu(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._lines) do
		local var_10_0 = false

		if arg_10_0._nodes[iter_10_0] and arg_10_0._nodes[iter_10_0]:isActive() then
			var_10_0 = true
		end

		local var_10_1 = var_10_0 and "#914B24" or "#5F4C3F"

		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			SLFramework.UGUI.GuiHelper.SetColor(iter_10_3, var_10_1)
		end
	end
end

function var_0_0.createCurrencyItem(arg_11_0)
	local var_11_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0:getResInst(arg_11_0.viewContainer._viewSetting.otherRes.currency, arg_11_0._topCurrencyRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, PinballCurrencyItem):setCurrencyType(iter_11_1)
	end
end

function var_0_0._selectTalent(arg_12_0, arg_12_1)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio6)

	if not arg_12_0._godetail.activeSelf then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio7)
	end

	gohelper.setActive(arg_12_0._godetail, true)
	gohelper.setActive(arg_12_0._gobtns, false)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._nodes) do
		iter_12_1:setSelect(arg_12_1 == iter_12_0)

		if arg_12_1 == iter_12_0 then
			local var_12_0 = iter_12_1._data
			local var_12_1 = iter_12_1:isActive()
			local var_12_2 = iter_12_1:canActive()

			arg_12_0._txttalentname.text = var_12_0.name
			arg_12_0._txttalentdec.text = var_12_0.desc

			gohelper.setActive(arg_12_0._btncancel, not var_12_1)
			gohelper.setActive(arg_12_0._btnlight, not var_12_1)
			gohelper.setActive(arg_12_0._golightgrey, not var_12_1 and not var_12_2)

			arg_12_0._nowSelect = iter_12_1

			if not var_12_1 then
				arg_12_0:updateCost(var_12_0.cost)
			else
				arg_12_0:updateCost("")
			end
		end
	end
end

function var_0_0.updateCost(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if not string.nilorempty(arg_13_1) then
		local var_13_1 = GameUtil.splitString2(arg_13_1, true)

		for iter_13_0, iter_13_1 in pairs(var_13_1) do
			table.insert(var_13_0, {
				resType = iter_13_1[1],
				value = iter_13_1[2]
			})
		end
	end

	arg_13_0._costNoEnough = nil

	gohelper.CreateObjList(arg_13_0, arg_13_0._createCostItem, var_13_0, nil, arg_13_0._gocostitem)
end

function var_0_0._createCostItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChildTextMesh(arg_14_1, "#txt_num")
	local var_14_1 = gohelper.findChildImage(arg_14_1, "#txt_num/#image_icon")
	local var_14_2 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_14_2.resType]

	if not var_14_2 then
		logError("资源配置不存在" .. arg_14_2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_14_1, var_14_2.icon)

	local var_14_3 = ""

	if arg_14_2.value > PinballModel.instance:getResNum(arg_14_2.resType) then
		var_14_3 = "<color=#FC8A6A>"
		arg_14_0._costNoEnough = arg_14_0._costNoEnough or var_14_2.name
	end

	var_14_0.text = string.format("%s-%d", var_14_3, arg_14_2.value)
end

function var_0_0._cancelSelect(arg_15_0)
	gohelper.setActive(arg_15_0._godetail, false)
	gohelper.setActive(arg_15_0._gobtns, true)

	for iter_15_0, iter_15_1 in pairs(arg_15_0._nodes) do
		iter_15_1:setSelect(false)
	end

	arg_15_0._nowSelect = nil
end

function var_0_0.onClickModalMask(arg_16_0)
	arg_16_0:closeThis()
end

function var_0_0._learnTalent(arg_17_0)
	if not arg_17_0._nowSelect or not arg_17_0._selectData then
		return
	end

	local var_17_0 = arg_17_0._selectData.co
	local var_17_1 = arg_17_0._nowSelect._data.needLv
	local var_17_2 = PinballModel.instance:getBuildingInfoById(var_17_0.id)

	if var_17_2 and var_17_1 > var_17_2.level then
		GameFacade.showToast(ToastEnum.Act178TalentLvNotEnough, var_17_0.name, var_17_1)

		return
	end

	if not arg_17_0._nowSelect:canActive() then
		GameFacade.showToast(ToastEnum.Act178TalentCondition2)

		return
	end

	if arg_17_0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_17_0._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178UnlockTalent(VersionActivity2_4Enum.ActivityId.Pinball, arg_17_0._nowSelect._data.id, arg_17_0._onLearnTalent, arg_17_0)
end

function var_0_0._onLearnTalent(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 ~= 0 then
		return
	end

	if not arg_18_0._nowSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio8)
	arg_18_0._nowSelect:setSelect(false)
	arg_18_0._nowSelect:onLearn()
	arg_18_0:_refreshLineStatu()
	arg_18_0:_cancelSelect()
end

return var_0_0
