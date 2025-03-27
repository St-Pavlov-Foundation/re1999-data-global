module("modules.logic.versionactivity2_4.pinball.view.PinballBuildView", package.seeall)

slot0 = class("PinballBuildView", BaseView)

function slot0.onInitView(slot0)
	slot0._golist = gohelper.findChild(slot0.viewGO, "#go_list")
	slot0._goitem = gohelper.findChild(slot0._golist, "#go_item")
	slot0._gobuild = gohelper.findChild(slot0.viewGO, "#go_build")
	slot0._godone = gohelper.findChild(slot0.viewGO, "#go_done")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "#txt_title")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	slot0._btnBuild = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_build/#btn_build")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lock/#btn_lock")
	slot0._goeffectitem = gohelper.findChild(slot0.viewGO, "#go_add/go_item")
	slot0._gocostitem1 = gohelper.findChild(slot0.viewGO, "#go_build/#go_currency/go_item")
	slot0._gocostitem2 = gohelper.findChild(slot0.viewGO, "#go_lock/#go_currency/go_item")
	slot0._topCurrencyRoot = gohelper.findChild(slot0.viewGO, "#go_topright")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.onClickModalMask, slot0)
	slot0._btnBuild:AddClickListener(slot0.onBuildClick, slot0)
	slot0._btnLock:AddClickListener(slot0.onLockClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnBuild:RemoveClickListener()
	slot0._btnLock:RemoveClickListener()
end

function slot0.onClickModalMask(slot0)
	gohelper.setActive(slot0.viewGO, false)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	slot0:createCurrencyItem()

	slot0._items = {}

	gohelper.CreateObjList(slot0, slot0.createItem, PinballConfig.instance:getAllBuildingCo(VersionActivity2_4Enum.ActivityId.Pinball, slot0.viewParam.size), slot0._golist, slot0._goitem, PinballBuildItem)
	slot0:onSelect(1)
end

function slot0.createItem(slot0, slot1, slot2, slot3)
	slot1:initData(slot2, slot3)

	slot0._items[slot3] = slot1

	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1.go, "#btn_click"), slot0.onSelect, slot0, slot3)
end

function slot0.onSelect(slot0, slot1)
	slot0._curSelectIndex = slot1

	for slot5, slot6 in pairs(slot0._items) do
		slot6:setSelect(slot1 == slot6._index)

		if slot1 == slot6._index then
			slot0:_refreshView(slot6)
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

function slot0._refreshView(slot0, slot1)
	slot2 = slot1:isLock()
	slot4 = slot1._data

	gohelper.setActive(slot0._golock, slot2)
	gohelper.setActive(slot0._godone, slot1:isDone())
	gohelper.setActive(slot0._gobuild, not slot2 and not slot3)

	slot0._txttitle.text = slot4.desc
	slot0._txtdesc.text = slot4.desc2

	slot0:updateEffect(slot4)
	slot0:updateCost(slot4)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnBuild.gameObject, not not slot0._costNoEnough)
end

function slot0.updateEffect(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.effect) then
		for slot8, slot9 in pairs(GameUtil.splitString2(slot3, true)) do
			if slot9[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(slot2, {
					resType = PinballEnum.ResType.Score,
					value = slot9[2]
				})
			elseif slot9[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(slot2, {
					resType = PinballEnum.ResType.Food,
					value = slot9[2]
				})
			elseif slot9[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(slot2, {
					resType = PinballEnum.ResType.Food,
					value = slot9[2],
					text = luaLang("pinball_food_need")
				})
			elseif slot9[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(slot2, {
					resType = PinballEnum.ResType.Play,
					value = slot9[2]
				})
			elseif slot9[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(slot2, {
					resType = PinballEnum.ResType.Play,
					value = slot9[2],
					text = luaLang("pinball_play_need")
				})
			end
		end
	end

	gohelper.CreateObjList(slot0, slot0._createEffectItem, slot2, nil, slot0._goeffectitem)
end

function slot0.updateCost(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.cost) then
		for slot8, slot9 in pairs(GameUtil.splitString2(slot3, true)) do
			table.insert(slot2, {
				resType = slot9[1],
				value = slot9[2]
			})
		end
	end

	slot0._costNoEnough = nil

	gohelper.CreateObjList(slot0, slot0._createCostItem, slot2, nil, slot0._gocostitem1)
	gohelper.CreateObjList(slot0, slot0._createCostItem, slot2, nil, slot0._gocostitem2)
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

function slot0._createEffectItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot5 = gohelper.findChildImage(slot1, "#txt_num/#image_icon")

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.resType] then
		logError("资源配置不存在" .. slot2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot5, slot6.icon)

	slot4.text = GameUtil.getSubPlaceholderLuaLang(luaLang("PinballBuildView_createEffectItem"), {
		slot2.text or slot6.name,
		slot2.value
	})
end

function slot0.onBuildClick(slot0)
	if slot0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, slot0._items[slot0._curSelectIndex]._data.id, PinballEnum.BuildingOperType.Build, slot0.viewParam.index)
	slot0:onClickModalMask()
end

function slot0.onLockClick(slot0)
	slot0._items[slot0._curSelectIndex]:isLock(true)
end

return slot0
