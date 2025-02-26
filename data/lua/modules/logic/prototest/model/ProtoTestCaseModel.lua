module("modules.logic.prototest.model.ProtoTestCaseModel", package.seeall)

slot0 = class("ProtoTestCaseModel", MixScrollModel)

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		slot8 = #slot7.value
		slot9 = 45 + slot8 * 27.5

		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot8, slot9, slot9))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
