module("modules.logic.activity.view.Vxax_Special_BaseView", package.seeall)

slot0 = class("Vxax_Special_BaseView", Activity101SignViewBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
end

function slot0.internal_onOpen(slot0)
	if slot0:openMode() == Activity101SignViewBase.eOpenMode.ActivityBeginnerView then
		slot0:internal_set_actId(slot0.viewParam.actId)
		gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
		slot0:_internal_onOpen()
		slot0:_refresh()
	elseif slot1 == slot2.PaiLian then
		slot0:_internal_onOpen()
		slot0:_refresh()
	else
		assert(false)
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0.addReward(slot0, slot1, slot2, slot3)
	slot4 = slot3.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot4:setIndex(slot1)
	slot4:init(slot2)
	table.insert(slot0.__itemList, slot4)

	return slot4
end

function slot0._createList(slot0)
	if slot0.__itemList then
		return
	end

	slot0.__itemList = {}

	for slot5, slot6 in ipairs(slot0:getDataList()) do
		slot0:addReward(slot5, slot0:onFindChind_RewardGo(slot5), V2a3_Special_SignItem):onUpdateMO(slot6)
	end
end

function slot0._refreshList(slot0, slot1)
	slot2 = nil

	slot0:onRefreshList((not slot1 or slot0:getTempDataList()) and slot0:getDataList())
end

function slot0.onRefreshList(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0.__itemList

	for slot6, slot7 in ipairs(slot1) do
		if slot2[slot6] then
			slot8:onUpdateMO(slot7)
			slot8:setActive(true)
		end
	end

	for slot6 = #slot1 + 1, #slot2 do
		slot2[slot6]:setActive(false)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onFindChind_RewardGo(slot0, slot1)
	assert(false, "please override this function")
end

function slot0.onStart(slot0)
	slot0:_createList()
end

return slot0
