module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessViewController", package.seeall)

slot0 = class("Va3ChessViewController", BaseController)

function slot0._initResisterFunc(slot0)
	slot0._viewTypeFuncDict = {
		[Va3ChessEnum.ViewType.Reward] = slot0:_registerRewardViewFunc()
	}
end

function slot0._registerRewardViewFunc(slot0)
	return {
		[Va3ChessEnum.ActivityId.Act142] = function (slot0, slot1)
			ViewMgr.instance:openView(ViewName.Activity142GetCollectionView, slot1)
		end
	}
end

function slot0._openView(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._viewTypeFuncDict then
		slot0:_initResisterFunc()
	end

	if slot0._viewTypeFuncDict[slot1][slot2] then
		slot7[slot2](slot3, slot4, slot5, slot6)

		return true
	end

	return false
end

function slot0.openRewardView(slot0, slot1, slot2, slot3)
	return slot0:_openView(Va3ChessEnum.ViewType.Reward, slot1, slot2, slot3)
end

slot0.instance = slot0.New()

return slot0
