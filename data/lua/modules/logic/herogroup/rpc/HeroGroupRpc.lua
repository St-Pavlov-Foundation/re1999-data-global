module("modules.logic.herogroup.rpc.HeroGroupRpc", package.seeall)

slot0 = class("HeroGroupRpc", BaseRpc)

function slot0.sendGetHeroGroupListRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroGroupModule_pb.GetHeroGroupListRequest(), slot1, slot2)
end

function slot0.onReceiveGetHeroGroupListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroGroupModel.instance:onGetHeroGroupList(slot2.groupInfoList)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnGetHeroGroupList)
	end
end

function slot0.sendUpdateHeroGroupRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = HeroGroupModule_pb.UpdateHeroGroupRequest()
	slot9.groupInfo.groupId = slot1
	slot9.groupInfo.name = slot3 or ""

	if slot4 then
		slot9.groupInfo.clothId = slot4
	end

	if slot2 then
		for slot13, slot14 in ipairs(slot2) do
			table.insert(slot9.groupInfo.heroList, slot14)
		end
	end

	if slot5 then
		for slot13 = 0, 3 do
			if slot5[slot13] then
				HeroDef_pb.HeroGroupEquip().index = slot14.index

				for slot19, slot20 in ipairs(slot14.equipUid) do
					table.insert(slot15.equipUid, slot20)
				end

				table.insert(slot9.groupInfo.equips, slot15)
			end
		end
	end

	slot0:sendMsg(slot9, slot7, slot8)
end

function slot0.onReceiveUpdateHeroGroupReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(slot2.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function slot0.sendSetHeroGroupEquipRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroGroupModule_pb.SetHeroGroupEquipRequest()
	slot4.groupId = slot1
	slot4.equip.index = slot2

	for slot8, slot9 in ipairs(slot3) do
		table.insert(slot4.equip.equipUid, slot9)
	end

	if Activity104Model.instance:isSeasonChapter() then
		slot5 = HeroGroupModel.instance:getCurGroupMO()
		slot5.equips[slot2].equipUid = slot3

		slot5:updatePosEquips(slot4.equip)
		HeroGroupModel.instance:saveCurGroupData()

		return
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveSetHeroGroupEquipReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot4 = slot2.equip

	if HeroGroupModel.instance:getById(slot2.groupId) then
		slot5:updatePosEquips(slot4)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot4.index)

		if slot0._showSetHeroGroupEquipTip then
			slot0._showSetHeroGroupEquipTip()

			slot0._showSetHeroGroupEquipTip = nil
		end
	end
end

function slot0.sendSetHeroGroupSnapshotRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot3.snapshotId = slot1
	slot3.snapshotSubId = slot2

	slot0:sendMsg(slot3, slot4, slot5)
end

function slot0.onReceiveSetHeroGroupSnapshotReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	logNormal("编队快照保存成功")
	HeroGroupController.instance:onReceiveHeroGroupSnapshot(slot2)

	if slot0._showSetHeroGroupEquipTip then
		slot0._showSetHeroGroupEquipTip()

		slot0._showSetHeroGroupEquipTip = nil
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, slot2.snapshotId, slot2.snapshotSubId)
end

function slot0.onReceiveUpdateHeroGroupPush(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(slot2.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function slot0.sendGetHeroGroupCommonListRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroGroupModule_pb.GetHeroGroupCommonListRequest(), slot1, slot2)
end

function slot0.onReceiveGetHeroGroupCommonListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroGroupModel.instance:onGetCommonGroupList(slot2)
	end
end

function slot0.sendChangeHeroGroupSelectRequest(slot0, slot1, slot2)
	slot3 = HeroGroupModule_pb.ChangeHeroGroupSelectRequest()
	slot3.id = slot1
	slot3.currentSelect = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveChangeHeroGroupSelectReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendUpdateHeroGroupNameRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = HeroGroupModule_pb.UpdateHeroGroupNameRequest()
	slot6.id = slot1
	slot6.currentSelect = slot2
	slot6.name = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveUpdateHeroGroupNameReply(slot0, slot1, slot2)
end

function slot0.sendGetHeroGroupSnapshotListRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroGroupModule_pb.GetHeroGroupSnapshotListRequest()
	slot4.snapshotId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetHeroGroupSnapshotListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroGroupSnapshotModel.instance:onReceiveGetHeroGroupSnapshotListReply(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
