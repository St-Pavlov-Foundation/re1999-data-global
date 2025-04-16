module("modules.logic.activity.view.Vxax_Special_SignItemViewContainer", package.seeall)

slot0 = class("Vxax_Special_SignItemViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	assert(false, "please override this function")
end

function slot0.view(slot0)
	assert(false, "please override this function")
end

function slot0.actId(slot0)
	return slot0.viewParam.actId
end

function slot0.itemCo2TIQ(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	assert(#string.split(slot1, "#") >= 2, "[Vxax_Special_SignItemViewContainer] invalid itemCo=" .. tostring(slot1))

	slot3 = string.split(slot1, "#")

	return tonumber(slot3[1]), tonumber(slot3[2]), tonumber(slot3[3])
end

function slot0.getItemConfig(slot0, slot1, slot2)
	slot3 = ItemConfigGetDefine.instance:getItemConfigFunc(slot1)

	assert(slot3, "[Vxax_Special_SignItemViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(slot1))

	slot4 = slot3(slot2)

	assert(slot4, "[Vxax_Special_SignItemViewContainer] item config not found materialType=" .. tostring(slot1) .. " id=" .. tostring(slot2))

	return slot4
end

function slot0.getItemIconResUrl(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return ""
	end

	slot3 = ItemIconGetDefine.instance:getItemIconFunc(slot1)

	assert(slot3, "[Vxax_Special_SignItemViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(slot1))

	return slot3(slot0:getItemConfig(slot1, slot2)) or ""
end

function slot0.Vxax_Special_xxxSignView_Container(slot0, slot1)
	function slot0.buildViews(slot0)
		slot0._view = uv0.New()

		return {
			slot0._view
		}
	end

	function slot0.view(slot0)
		return slot0._view
	end
end

function slot0.Vxax_Special_FullSignView(slot0, slot1, slot2)
end

function slot0.Vxax_Special_PanelSignView(slot0, slot1, slot2)
end

function slot1(slot0)
	return _G[string.format(slot0, GameBranchMgr.instance:getMajorVer(), GameBranchMgr.instance:getMinorVer())]
end

function slot0.Vxax_Special_FullSignView_ContainerImpl()
	return uv0("V%sa%s_Special_FullSignViewContainer")
end

function slot0.Vxax_Special_PanelSignView_ContainerImpl()
	return uv0("V%sa%s_Special_PanelSignViewContainer")
end

return slot0
