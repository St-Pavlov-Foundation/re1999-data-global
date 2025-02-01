module("modules.logic.toughbattle.view.ToughBattleRoleListComp", package.seeall)

slot0 = class("ToughBattleRoleListComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.viewParam = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._anim = gohelper.findChild(slot1, "root"):GetComponent(typeof(UnityEngine.Animator))
	slot3 = gohelper.findChild(gohelper.findChild(slot1, "root/#go_rolelist"), "#go_item")
	slot0._items = slot0:getUserDataTb_()
	slot6 = nil

	for slot10 = 1, 3 do
	end

	gohelper.CreateObjList(slot0, slot0.createItem, {
		[slot10] = {
			co = slot11,
			isNewGet = ((slot0.viewParam.mode ~= ToughBattleEnum.Mode.Act or lua_activity158_challenge.configDict) and lua_siege_battle.configDict)[slot0:getInfo().passChallengeIds[slot10]] and slot11.sort == slot0.viewParam.lastFightSuccIndex
		}
	}, slot2, slot3, ToughBattleRoleItem)
	slot0:setSelect(slot0._selectCo)
end

function slot0.getInfo(slot0)
	return slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function slot0.createItem(slot0, slot1, slot2, slot3)
	slot0._items[slot3] = slot1

	slot0._items[slot3]:initData(slot2)
	slot0._items[slot3]:setClickCallBack(slot0._onItemClick, slot0)
end

function slot0._onItemClick(slot0, slot1)
	if slot0._clickCallBack then
		slot0._clickCallBack(slot0._callobj, slot1)
	end
end

function slot0.setClickCallBack(slot0, slot1, slot2)
	slot0._clickCallBack = slot1
	slot0._callobj = slot2
end

function slot0.setSelect(slot0, slot1)
	slot0._selectCo = slot1

	if slot0._items then
		for slot5 = 1, #slot0._items do
			slot0._items[slot5]:setSelect(slot1)
		end
	end
end

function slot0.playAnim(slot0, slot1)
	if not slot0._anim then
		return
	end

	slot0._anim:Play(slot1, 0, 0)

	if slot1 == "open" and slot0._items then
		for slot5 = 1, #slot0._items do
			slot0._items[slot5]:playFirstAnim()
		end
	end
end

function slot0.onDestroy(slot0)
	slot0._clickCallBack = nil
	slot0._callobj = nil
end

return slot0
