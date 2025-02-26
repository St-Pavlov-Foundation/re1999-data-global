module("modules.logic.gm.view.GMFightEntityBuffView", package.seeall)

slot0 = class("GMFightEntityBuffView", BaseView)
slot0.ClickSearchItem = "ClickSearchItem"

function slot0.onInitView(slot0)
	slot0._maskGO = gohelper.findChild(slot0.viewGO, "buff/searchList")
	slot0._scrollTr = gohelper.findChild(slot0.viewGO, "buff/searchList/scroll").transform
	slot0._input = gohelper.findChildTextMeshInputField(slot0.viewGO, "buff/add/input")
	slot0._btnAdd = gohelper.findChildButton(slot0.viewGO, "buff/add/btnAdd")
end

function slot0.addEvents(slot0)
	slot0._btnAdd:AddClickListener(slot0._onClickAddBuff, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._input.gameObject):AddClickListener(slot0._onClickInpItem, slot0, nil)
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):AddClickListener(slot0._onClickMask, slot0, nil)
	slot0._input:AddOnValueChanged(slot0._onInpValueChanged, slot0)
	GMController.instance:registerCallback(uv0.ClickSearchItem, slot0._onClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAdd:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._input.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):RemoveClickListener()
	slot0._input:RemoveOnValueChanged()
	GMController.instance:unregisterCallback(uv0.ClickSearchItem, slot0._onClickItem, slot0)
end

function slot0.onOpen(slot0)
	slot0:_hideScroll()
	slot0._input:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMEntityBuffSearch, ""))
end

function slot0._onClickAddBuff(slot0)
	if tonumber(slot0._input:GetText()) and lua_skill_buff.configDict[slot1] then
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMEntityBuffSearch, tostring(slot1))
		GameFacade.showToast(ToastEnum.IconId, "add buff " .. slot1)

		slot3 = GMFightEntityModel.instance.entityMO
		slot7 = "fightAddBuff %s %s"
		slot8 = tostring(slot3.id)

		GMRpc.instance:sendGMRequest(string.format(slot7, slot8, tostring(slot1)))

		slot0._oldBuffUidDict = {}

		for slot7, slot8 in ipairs(slot3:getBuffList()) do
			slot0._oldBuffUidDict[slot8.id] = true
		end

		FightRpc.instance:sendEntityInfoRequest(slot3.id)
		slot0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onGetEntityInfo, slot0)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff not exist " .. slot0._input:GetText())
	end
end

function slot0._onGetEntityInfo(slot0, slot1)
	slot0:removeEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onGetEntityInfo, slot0)

	if not GMFightEntityModel.instance.entityMO then
		return
	end

	for slot6, slot7 in ipairs(slot2:getBuffList()) do
		if not slot0._oldBuffUidDict[slot7.id] then
			logError("add buff " .. slot7.buffId)

			if FightHelper.getEntity(slot2.id) and slot8.buff then
				slot8.buff:addBuff(slot7, false, 0)
				FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot2.id, FightEnum.EffectType.BUFFADD, slot7.buffId, slot7.uid, 0)
			end
		else
			FightController.instance:dispatchEvent(FightEvent.GMForceRefreshNameUIBuff, slot2.id)
		end
	end
end

function slot0._onClickInpItem(slot0)
	slot0:_showScroll()
end

function slot0._onClickMask(slot0)
	slot0:_hideScroll()
end

function slot0._showScroll(slot0)
	gohelper.setActive(slot0._maskGO, true)
	slot0:_checkBuildItems()
end

function slot0._hideScroll(slot0)
	gohelper.setActive(slot0._maskGO, false)
end

function slot0._onClickItem(slot0, slot1)
	slot0._input:SetText(slot1.buffId)
	slot0:_hideScroll()
end

function slot0._onInpValueChanged(slot0, slot1)
	slot0:_checkBuildItems()
end

function slot0._checkBuildItems(slot0)
	if not slot0._searchScrollView then
		slot1 = ListScrollParam.New()
		slot1.scrollGOPath = "buff/searchList/scroll"
		slot1.prefabType = ScrollEnum.ScrollPrefabFromView
		slot1.prefabUrl = "buff/searchList/scroll/item"
		slot1.cellClass = GMFightEntityBuffSearchItem
		slot1.scrollDir = ScrollEnum.ScrollDirV
		slot1.lineCount = 1
		slot1.cellWidth = 450
		slot1.cellHeight = 50
		slot1.cellSpaceH = 0
		slot1.cellSpaceV = 0
		slot0._searchScrollModel = ListScrollModel.New()
		slot0._searchScrollView = LuaListScrollView.New(slot0._searchScrollModel, slot1)

		slot0:addChildView(slot0._searchScrollView)

		slot0._buffList = {}

		for slot5, slot6 in ipairs(lua_skill_buff.configList) do
			table.insert(slot0._buffList, {
				buffId = tostring(slot6.id),
				name = slot6.name
			})
		end
	end

	slot1 = nil

	if string.nilorempty(slot0._input:GetText()) then
		slot1 = slot0._buffList
	else
		if slot0._tempList then
			tabletool.clear(slot0._tempList)
		else
			slot0._tempList = {}
		end

		for slot6, slot7 in ipairs(slot0._buffList) do
			if string.find(slot7.name, slot2) or string.find(slot7.buffId, slot2) == 1 then
				table.insert(slot0._tempList, slot7)
			end
		end

		slot1 = slot0._tempList
	end

	recthelper.setHeight(slot0._scrollTr, Mathf.Clamp(#slot1, 1, 10) * 50)
	slot0._searchScrollModel:setList(slot1)
end

return slot0
