module("modules.logic.season.view1_3.Season1_3EquipTagSelect", package.seeall)

slot0 = class("Season1_3EquipTagSelect", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._controller = slot1
	slot0._dropListPath = slot2
	slot0._defaultColor = slot3 or "#cac8c5"
end

function slot0._editableInitView(slot0)
	slot0._dropdowntag = gohelper.findChildDropdown(slot0.viewGO, slot0._dropListPath)
	slot0._txtlabel = gohelper.findChildText(slot0._dropdowntag.gameObject, "Label")
	slot0._imagearrow = gohelper.findChildImage(slot0._dropdowntag.gameObject, "arrow")

	slot0._dropdowntag:AddOnValueChanged(slot0.handleDropValueChanged, slot0)

	slot0._clicktag = gohelper.getClick(slot0._dropdowntag.gameObject)

	slot0._clicktag:AddClickListener(slot0.handleClickTag, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._dropdowntag then
		slot0._dropdowntag:RemoveOnValueChanged()

		slot0._dropdowntag = nil
	end

	if slot0._clicktag then
		slot0._clicktag:RemoveClickListener()

		slot0._clicktag = nil
	end
end

function slot0.onOpen(slot0)
	if slot0._controller.getFilterModel then
		slot0._model = slot0._controller:getFilterModel()
	end

	if not slot0._model then
		return
	end

	slot0._dropdowntag:ClearOptions()
	slot0._dropdowntag:AddOptions(slot0._model:getOptions())
	slot0._dropdowntag:SetValue(0)
	slot0:refreshSelected()
end

function slot0.onClose(slot0)
end

function slot0.handleClickTag(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0.handleDropValueChanged(slot0, slot1)
	if slot0._controller.setSelectTag and slot0._model then
		slot0._controller:setSelectTag(slot1)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		slot0:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function slot0.refreshSelected(slot0)
	slot2 = nil
	slot2 = (slot0._model:getCurTagId() ~= Activity104EquipTagModel.NoTagId or slot0._defaultColor) and "#c66030"
	slot0._txtlabel.color = GameUtil.parseColor(slot2)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagearrow, slot2)
end

return slot0
