module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaInfosView", package.seeall)

local var_0_0 = class("NuoDiKaInfosView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._goenemy = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_enemy")
	arg_1_0._goenemyitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_enemy/#go_enemyitem")
	arg_1_0._goterrain = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_terrain")
	arg_1_0._goterrainitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_terrain/#go_terrainitem")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_item")
	arg_1_0._goitemitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_item/#go_itemitem")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose1OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._enemyList = {}
	arg_7_0._itemList = {}
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshEnemys()
	arg_9_0:refreshItems()
end

function var_0_0.refreshEnemys(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._enemyList) do
		iter_10_1:hide()
	end

	local var_10_0 = NuoDiKaMapModel.instance:getMapEnemys()

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		if not arg_10_0._enemyList[iter_10_3.enemyId] then
			arg_10_0._enemyList[iter_10_3.enemyId] = NuoDiKaInfoItem.New()

			local var_10_1 = gohelper.clone(arg_10_0._goenemyitem, arg_10_0._goenemy)

			arg_10_0._enemyList[iter_10_3.enemyId]:init(var_10_1, NuoDiKaEnum.EventType.Enemy)
		end

		arg_10_0._enemyList[iter_10_3.enemyId]:setItem(iter_10_3)
	end
end

function var_0_0.refreshItems(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._itemList) do
		iter_11_1:hide()
	end

	local var_11_0 = NuoDiKaMapModel.instance:getMapItems()

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		if not arg_11_0._itemList[iter_11_3.itemId] then
			arg_11_0._itemList[iter_11_3.itemId] = NuoDiKaInfoItem.New()

			local var_11_1 = gohelper.clone(arg_11_0._goitemitem, arg_11_0._goitem)

			arg_11_0._itemList[iter_11_3.itemId]:init(var_11_1, NuoDiKaEnum.EventType.Item)
		end

		arg_11_0._itemList[iter_11_3.itemId]:setItem(iter_11_3)
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._enemyList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._enemyList) do
			iter_13_1:destory()
		end

		arg_13_0._enemyList = nil
	end

	if arg_13_0._itemList then
		for iter_13_2, iter_13_3 in pairs(arg_13_0._itemList) do
			iter_13_3:destory()
		end

		arg_13_0._itemList = nil
	end
end

return var_0_0
