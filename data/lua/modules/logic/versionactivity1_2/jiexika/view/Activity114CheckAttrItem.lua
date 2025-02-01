module("modules.logic.versionactivity1_2.jiexika.view.Activity114CheckAttrItem", package.seeall)

slot0 = class("Activity114CheckAttrItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtLevel = gohelper.findChildTextMesh(slot1, "txt_info")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._txtLevel.text = string.format("%d[%s]", slot1.value, slot1.name)

	if slot1.isAttr then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLevel, "#e55151")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLevel, "#9ee091")
	end
end

function slot0.onDestroyView(slot0)
	slot0._txtLevel = nil
end

return slot0
