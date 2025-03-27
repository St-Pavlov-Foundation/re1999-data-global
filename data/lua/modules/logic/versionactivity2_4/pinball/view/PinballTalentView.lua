module("modules.logic.versionactivity2_4.pinball.view.PinballTalentView", package.seeall)

slot0 = class("PinballTalentView", BaseView)

function slot0.onInitView(slot0)
	slot0._fullclick = gohelper.findChildClick(slot0.viewGO, "#simage_FullBG")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_detail")
	slot0._txttalentname = gohelper.findChildTextMesh(slot0.viewGO, "#go_detail/#txt_talentname")
	slot0._txttalentdec = gohelper.findChildTextMesh(slot0.viewGO, "#go_detail/#txt_talentdec")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_cancel")
	slot0._btnlight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_light")
	slot0._golightgrey = gohelper.findChild(slot0.viewGO, "#go_detail/#btn_light/grey")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "#go_detail/#go_currency/go_item")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btn")
	slot0._gotabitem = gohelper.findChild(slot0.viewGO, "#go_btn/#btn_building")
	slot0._talentitem = gohelper.findChild(slot0.viewGO, "#go_talentree/#go_talenitem")
	slot0._talentroot = gohelper.findChild(slot0.viewGO, "#go_talentree/#go_talengroup")
	slot0._topCurrencyRoot = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._treeAnim = gohelper.findChildAnim(slot0.viewGO, "#go_talentree")
end

function slot0.addEvents(slot0)
	slot0._fullclick:AddClickListener(slot0._cancelSelect, slot0)
	slot0._btncancel:AddClickListener(slot0._cancelSelect, slot0)
	slot0._btnlight:AddClickListener(slot0._learnTalent, slot0)
end

function slot0.removeEvents(slot0)
	slot0._fullclick:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnlight:RemoveClickListener()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._talentitem, false)
	slot0:initNodeAndLine()
	slot0:initTab()
	slot0:createCurrencyItem()
end

function slot0.initTab(slot0)
	slot2 = {}
	slot3 = nil

	for slot7, slot8 in ipairs(PinballModel.instance:getAllTalentBuildingId()) do
		slot11 = 1

		for slot16, slot17 in pairs(GameUtil.splitString2(lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot8][1].effect, true) or {}) do
			if slot17[1] == PinballEnum.BuildingEffectType.UnlockTalent then
				slot11 = slot17[2]

				break
			end
		end

		table.insert(slot2, {
			co = slot9,
			type = slot11
		})

		if slot0.viewParam.info.baseCo == slot9 then
			slot3 = slot13
		end
	end

	slot0._tabs = {}

	gohelper.CreateObjList(slot0, slot0._createTab, slot2, nil, slot0._gotabitem, PinballTalentTabItem)
	slot0:_onTabClick(slot3 or slot2[1])
end

function slot0._createTab(slot0, slot1, slot2, slot3)
	slot0._tabs[slot3] = slot1

	slot1:setData(slot2)
	slot1:setClickCall(slot0._onTabClick, slot0)
end

function slot0._onTabClick(slot0, slot1)
	if slot1 ~= slot0._selectData then
		slot0._selectData = slot1

		for slot5, slot6 in pairs(slot0._tabs) do
			slot6:setSelectData(slot1)
		end

		slot0:initTalent()
		slot0:_refreshLineStatu()
		slot0:_cancelSelect()
		slot0._treeAnim:Play("open", 0, 0)
	end
end

function slot0.initNodeAndLine(slot0)
	slot2 = gohelper.findChild(slot0.viewGO, "#go_talentree/#go_talengroup").transform
	slot0._lines = {}
	slot0._nodes = {}

	for slot6 = 0, gohelper.findChild(slot0.viewGO, "#go_talentree/frame").transform.childCount - 1 do
		if string.match(slot1:GetChild(slot6).name, "^line(.+)$") then
			for slot14, slot15 in ipairs(string.split(slot9, "_") or {}) do
				if not slot0._lines[slot15] then
					slot0._lines[slot15] = slot0:getUserDataTb_()
				end

				table.insert(slot0._lines[slot15], gohelper.findChildImage(slot7.gameObject, ""))
			end
		end
	end

	for slot6 = 0, slot2.childCount - 1 do
		slot7 = slot2:GetChild(slot6)
		slot8 = slot7.name
		slot9 = gohelper.clone(slot0._talentitem, slot7.gameObject)

		gohelper.setActive(slot9, true)

		slot0._nodes[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, PinballTalentItem)

		slot0:addClickCb(gohelper.getClick(slot9), slot0._selectTalent, slot0, slot8)
	end
end

function slot0.initTalent(slot0)
	for slot5, slot6 in pairs(PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, slot0._selectData.type)) do
		if slot0._nodes[slot6.point] then
			slot0._nodes[slot6.point]:setData(slot6, slot0._selectData.co)
		end
	end

	slot0:_refreshLineStatu()
end

function slot0._refreshLineStatu(slot0)
	for slot4, slot5 in pairs(slot0._lines) do
		slot6 = false

		if slot0._nodes[slot4] and slot0._nodes[slot4]:isActive() then
			slot6 = true
		end

		for slot11, slot12 in pairs(slot5) do
			SLFramework.UGUI.GuiHelper.SetColor(slot12, slot6 and "#914B24" or "#5F4C3F")
		end
	end
end

function slot0.createCurrencyItem(slot0)
	for slot5, slot6 in ipairs({
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.currency, slot0._topCurrencyRoot), PinballCurrencyItem):setCurrencyType(slot6)
	end
end

function slot0._selectTalent(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio6)

	if not slot0._godetail.activeSelf then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio7)
	end

	gohelper.setActive(slot0._godetail, true)
	gohelper.setActive(slot0._gobtns, false)

	for slot5, slot6 in pairs(slot0._nodes) do
		slot6:setSelect(slot1 == slot5)

		if slot1 == slot5 then
			slot7 = slot6._data
			slot8 = slot6:isActive()
			slot0._txttalentname.text = slot7.name
			slot0._txttalentdec.text = slot7.desc

			gohelper.setActive(slot0._btncancel, not slot8)
			gohelper.setActive(slot0._btnlight, not slot8)
			gohelper.setActive(slot0._golightgrey, not slot8 and not slot6:canActive())

			slot0._nowSelect = slot6

			if not slot8 then
				slot0:updateCost(slot7.cost)
			else
				slot0:updateCost("")
			end
		end
	end
end

function slot0.updateCost(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		for slot7, slot8 in pairs(GameUtil.splitString2(slot1, true)) do
			table.insert(slot2, {
				resType = slot8[1],
				value = slot8[2]
			})
		end
	end

	slot0._costNoEnough = nil

	gohelper.CreateObjList(slot0, slot0._createCostItem, slot2, nil, slot0._gocostitem)
end

function slot0._createCostItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot5 = gohelper.findChildImage(slot1, "#txt_num/#image_icon")

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.resType] then
		logError("资源配置不存在" .. slot2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot5, slot6.icon)

	slot7 = ""

	if PinballModel.instance:getResNum(slot2.resType) < slot2.value then
		slot7 = "<color=#FC8A6A>"
		slot0._costNoEnough = slot0._costNoEnough or slot6.name
	end

	slot4.text = string.format("%s-%d", slot7, slot2.value)
end

function slot0._cancelSelect(slot0)
	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._gobtns, true)

	for slot4, slot5 in pairs(slot0._nodes) do
		slot5:setSelect(false)
	end

	slot0._nowSelect = nil
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._learnTalent(slot0)
	if not slot0._nowSelect or not slot0._selectData then
		return
	end

	slot2 = slot0._nowSelect._data.needLv

	if PinballModel.instance:getBuildingInfoById(slot0._selectData.co.id) and slot3.level < slot2 then
		GameFacade.showToast(ToastEnum.Act178TalentLvNotEnough, slot1.name, slot2)

		return
	end

	if not slot0._nowSelect:canActive() then
		GameFacade.showToast(ToastEnum.Act178TalentCondition2)

		return
	end

	if slot0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178UnlockTalent(VersionActivity2_4Enum.ActivityId.Pinball, slot0._nowSelect._data.id, slot0._onLearnTalent, slot0)
end

function slot0._onLearnTalent(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if not slot0._nowSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio8)
	slot0._nowSelect:setSelect(false)
	slot0._nowSelect:onLearn()
	slot0:_refreshLineStatu()
	slot0:_cancelSelect()
end

return slot0
