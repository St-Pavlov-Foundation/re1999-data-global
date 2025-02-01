module("modules.logic.messagebox.view.MessageOptionBoxViewContainer", package.seeall)

slot0 = class("MessageOptionBoxViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MessageOptionBoxView.New())

	return slot1
end

return slot0
