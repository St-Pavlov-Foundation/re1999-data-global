module("modules.logic.minors.view.DateOfBirthSelectionViewItem", package.seeall)

slot0 = class("DateOfBirthSelectionViewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._dropdown = gohelper.findChildDropdown(slot0.viewGO, "")
	slot0._arrowTran = gohelper.findChild(slot0.viewGO, "arrow").transform
	slot0._dropdownClick = gohelper.getClick(slot0.viewGO, "")
end

function slot0.addEvents(slot0)
	slot0._dropdownClick:AddClickListener(slot0._onDropdownClick, slot0)
	slot0._dropdown:AddOnValueChanged(slot0._onDropDownValueChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._dropdown:RemoveOnValueChanged()
	slot0._dropdownClick:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refresh()
end

function slot0.onDestroyView(slot0)
end

function slot0._onDropDownValueChange(slot0)
	slot1 = slot0._mo

	if slot1._parent:getDropDownSelectedIndex(slot1.type) ~= slot0._dropdown:GetValue() then
		slot2:onClickDropDownOption(slot3, slot4)
	end
end

function slot0._refresh(slot0)
	slot0._dropdown:ClearOptions()

	slot0._options = slot0:_getOptions()

	slot0._dropdown:AddOptions(slot0._options)
	slot0._dropdown:SetValue(slot0:_getSelectedIndex())
end

function slot0._getOptions(slot0)
	slot1 = slot0._mo

	return slot1._parent:getDropDownOption(slot1.type)
end

function slot0._getSelectedIndex(slot0)
	slot1 = slot0._mo

	return slot1._parent:getDropDownSelectedIndex(slot1.type)
end

slot1 = UnityEngine.UI.ScrollRect
slot4 = 5
slot5 = 12 + 73

function slot0._onDropdownClick(slot0)
	slot1 = slot0._dropdown:GetValue()

	if not gohelper.findChild(slot0.viewGO, "Dropdown List") then
		return
	end

	if not slot2:GetComponent(typeof(uv0)) then
		return
	end

	if not slot3.content then
		return
	end

	recthelper.setAnchorY(slot4, math.min(math.max(0, ((slot0._options and #slot0._options or 0) - uv2) * uv1), slot1 * uv1))
end

return slot0
