module("modules.logic.rouge.model.RougeResultReportListModel", package.seeall)

slot0 = class("RougeResultReportListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = RougeFavoriteModel.instance:getReviewInfoList()

	table.sort(slot1, function (slot0, slot1)
		return slot1.finishTime < slot0.finishTime
	end)
	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
