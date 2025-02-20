module("modules.logic.versionactivity2_3.act174.view.info.Act174RoleInfo", package.seeall)

slot0 = class("Act174RoleInfo", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "root")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		slot1 = slot0.viewParam.pos or Vector2.New(0, 0)

		recthelper.setAnchor(slot0.goRoot.transform, slot1.x, slot1.y)

		slot2 = Activity174Config.instance:getRoleCo(slot0.viewParam.roleId)

		if not slot0.characterItem then
			slot0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goRoot, Act174CharacterInfo, slot0)
		end

		slot0.characterItem:setData(slot2, slot0.viewParam.itemId)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
