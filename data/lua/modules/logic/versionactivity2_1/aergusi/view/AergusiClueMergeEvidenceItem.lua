module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeEvidenceItem", package.seeall)

slot0 = class("AergusiClueMergeEvidenceItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._index = slot2
	slot0._goselect = gohelper.findChild(slot1, "select")
	slot0._simageclue = gohelper.findChildSingleImage(slot1, "select/simage_clue")
	slot0._txtcluename = gohelper.findChildText(slot1, "select/name")
	slot0._goempty = gohelper.findChild(slot1, "empty")
	slot0._goselectframe = gohelper.findChild(slot1, "empty/selectframe")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "clickarea")

	slot0:_addEvents()
	gohelper.setActive(slot0._goempty, true)
	slot0:refreshItem()
end

function slot0.refreshItem(slot0)
	gohelper.setActive(slot0._goselectframe, AergusiModel.instance:getMergeClueState().pos[slot0._index] and slot1.selected)
	gohelper.setActive(slot0._goselect, slot1 and slot1.clueId > 0)

	if slot1 and slot1.clueId > 0 then
		slot2 = AergusiConfig.instance:getClueConfig(slot1.clueId)

		slot0._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(slot2.clueIcon))

		slot0._txtcluename.text = slot2.clueName
	else
		slot0._txtcluename.text = ""

		slot0._simageclue:UnLoadImage()
	end
end

function slot0._addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnClueOnClick, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, slot0.refreshItem, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, slot0.refreshItem, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, slot0.refreshItem, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, slot0.refreshItem, slot0)
end

function slot0._btnClueOnClick(slot0)
	if not AergusiModel.instance:getClueMergePosSelectState(slot0._index) then
		AergusiModel.instance:setClueMergePosSelect(slot0._index, true)
	else
		AergusiModel.instance:setClueMergePosClueId(slot0._index, 0)
		slot0:refreshItem()
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeItem)
end

function slot0.destroy(slot0)
	slot0._simageclue:UnLoadImage()
	slot0:_removeEvents()
end

return slot0
