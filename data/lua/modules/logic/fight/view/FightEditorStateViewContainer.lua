module("modules.logic.fight.view.FightEditorStateViewContainer", package.seeall)

slot0 = class("FightEditorStateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightEditorStateView.New()
	}
end

return slot0
