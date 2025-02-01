module("modules.common.others.UISimpleScrollViewComponent", package.seeall)

slot0 = class("UISimpleScrollViewComponent", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()

	slot0._sign_index = 0
end

function slot0.registScrollView(slot0, slot1, slot2)
	if not slot0._scroll_view then
		slot0._scroll_view = {}
	end

	slot3 = UISimpleScrollViewItem.New(slot0.parentClass, slot1, slot2)

	slot3:__onInit()
	slot3:startLogic(slot1, slot2)

	slot0._sign_index = slot0._sign_index + 1
	slot3.sign_index = slot0._sign_index

	table.insert(slot0._scroll_view, slot3)

	return slot3
end

function slot0.registSimpleScrollView(slot0, slot1, slot2, slot3)
	slot4 = slot0:registScrollView(slot1)

	slot4:useDefaultParam(slot2, slot3)

	return slot4
end

function slot0.releaseSelf(slot0)
	if slot0._scroll_view then
		for slot4, slot5 in ipairs(slot0._scroll_view) do
			if slot5.releaseSelf then
				slot5:releaseSelf()
			end

			slot5:__onDispose()
		end
	end

	slot0._scroll_view = nil

	slot0:__onDispose()
end

return slot0
