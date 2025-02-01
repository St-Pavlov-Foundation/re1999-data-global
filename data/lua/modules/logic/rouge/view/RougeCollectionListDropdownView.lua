module("modules.logic.rouge.view.RougeCollectionListDropdownView", package.seeall)

slot0 = class("RougeCollectionListDropdownView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/#btn_block")
	slot0._btnhole1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole1")
	slot0._btnunequip1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#btn_unequip1")
	slot0._goempty1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1")
	slot0._goarrow1 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1/#go_arrow1")
	slot0._simageruanpan1 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#simage_ruanpan1")
	slot0._btnhole2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole2")
	slot0._btnunequip2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#btn_unequip2")
	slot0._goempty2 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2")
	slot0._goarrow2 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2/#go_arrow2")
	slot0._simageruanpan2 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#simage_ruanpan2")
	slot0._btnhole3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole3")
	slot0._btnunequip3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#btn_unequip3")
	slot0._goempty3 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3")
	slot0._goarrow3 = gohelper.findChild(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3/#go_arrow3")
	slot0._simageruanpan3 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#simage_ruanpan3")
	slot0._scrollcollectiondesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_normal/#scroll_collectiondesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
	slot0._btnhole1:AddClickListener(slot0._btnhole1OnClick, slot0)
	slot0._btnunequip1:AddClickListener(slot0._btnunequip1OnClick, slot0)
	slot0._btnhole2:AddClickListener(slot0._btnhole2OnClick, slot0)
	slot0._btnunequip2:AddClickListener(slot0._btnunequip2OnClick, slot0)
	slot0._btnhole3:AddClickListener(slot0._btnhole3OnClick, slot0)
	slot0._btnunequip3:AddClickListener(slot0._btnunequip3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnhole1:RemoveClickListener()
	slot0._btnunequip1:RemoveClickListener()
	slot0._btnhole2:RemoveClickListener()
	slot0._btnunequip2:RemoveClickListener()
	slot0._btnhole3:RemoveClickListener()
	slot0._btnunequip3:RemoveClickListener()
end

function slot0._btnunequip1OnClick(slot0)
	slot0._holeMoList[1] = nil

	slot0:_updateHoles()
	slot0:_btnblockOnClick()
end

function slot0._btnunequip2OnClick(slot0)
	slot0._holeMoList[2] = nil

	slot0:_updateHoles()
	slot0:_btnblockOnClick()
end

function slot0._btnunequip3OnClick(slot0)
	slot0._holeMoList[3] = nil

	slot0:_updateHoles()
	slot0:_btnblockOnClick()
end

function slot0._btnblockOnClick(slot0)
	if slot0._clickHoleIndex then
		transformhelper.setLocalScale(slot0["_goarrow" .. slot0._clickHoleIndex].transform, 1, 1, 1)
	end

	gohelper.setActive(slot0._scrollviewGo, false)
	gohelper.setActive(slot0._btnblock, false)

	slot0._clickHoleIndex = nil
end

function slot0._btnhole1OnClick(slot0)
	slot0:_clickholeBtn(1)
end

function slot0._btnhole2OnClick(slot0)
	slot0:_clickholeBtn(2)
end

function slot0._btnhole3OnClick(slot0)
	slot0:_clickholeBtn(3)
end

function slot0._clickholeBtn(slot0, slot1)
	if slot0._clickHoleIndex then
		slot0:_btnblockOnClick()

		return
	end

	slot0._clickHoleIndex = slot1

	RougeFavoriteCollectionEnchantListModel.instance:initData(slot0._holeMoList[slot1])
	gohelper.addChild(slot0["_btnhole" .. slot1].gameObject, slot0._scrollviewGo)
	gohelper.setActive(slot0._scrollviewGo, true)
	gohelper.setActive(slot0._btnblock, true)
	recthelper.setAnchor(slot0._scrollviewGo.transform, -1, 374)
	transformhelper.setLocalScale(slot0["_goarrow" .. slot1].transform, 1, -1, 1)

	slot0._scrollview.verticalNormalizedPosition = 1
end

function slot0.getHoleMoList(slot0)
	return slot0._holeMoList
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btnhole1, false)
	gohelper.setActive(slot0._btnhole2, false)
	gohelper.setActive(slot0._btnhole3, false)

	slot0._holeMoList = {}
	slot0._holdNum = 3
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_normal/bottom/scrollview")
	slot0._scrollviewGo = slot0._scrollview.gameObject
	slot0._scrollAnchor = recthelper.getAnchor(slot0._scrollviewGo.transform)

	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, slot0._onClickCollectionListItem, slot0, LuaEventSystem.High)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionDropItem, slot0._onClickCollectionDropItem, slot0)
end

function slot0._onClickCollectionDropItem(slot0, slot1)
	slot0._holeMoList[slot0._clickHoleIndex] = slot1

	slot0:_updateHoles()
	slot0:_btnblockOnClick()
end

function slot0._updateHoles(slot0, slot1)
	for slot5 = 1, slot0._holdNum do
		slot8 = slot0._holeMoList[slot5] ~= nil

		gohelper.setActive(slot0["_simageruanpan" .. slot5], slot8)
		gohelper.setActive(slot0["_btnunequip" .. slot5], slot8)
		gohelper.setActive(slot0["_goempty" .. slot5], not slot8)

		if slot8 then
			slot6:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot7.id))
		end
	end

	if not slot1 then
		slot0.viewContainer:getCollectionListView():_refreshSelectCollectionInfo()
	end
end

function slot0._onClickCollectionListItem(slot0)
	TaskDispatcher.cancelTask(slot0._onRefresh, slot0)
	TaskDispatcher.runDelay(slot0._onRefresh, slot0, RougeEnum.CollectionListViewDelayTime)
end

function slot0._onRefresh(slot0)
	recthelper.setHeight(slot0._scrollcollectiondesc.transform, 372)

	if not RougeCollectionListModel.instance:getSelectedConfig() then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot1.id) then
		return
	end

	if slot3.holeNum > 0 then
		recthelper.setHeight(slot0._scrollcollectiondesc.transform, 293)
	end

	for slot7 = 1, slot0._holdNum do
		slot0._holeMoList[slot7] = nil

		slot0:_setHoleVisible(slot7, slot7 <= slot3.holeNum)
	end

	slot0:_updateHoles(true)
end

function slot0._setHoleVisible(slot0, slot1, slot2)
	gohelper.setActive(slot0["_btnhole" .. slot1], slot2)
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._scrollviewGo, false)
	gohelper.setActive(slot0._btnblock, false)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefresh, slot0)
end

return slot0
