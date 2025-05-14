module("modules.logic.rouge.view.RougeCollectionListDropdownView", package.seeall)

local var_0_0 = class("RougeCollectionListDropdownView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/#btn_block")
	arg_1_0._btnhole1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole1")
	arg_1_0._btnunequip1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#btn_unequip1")
	arg_1_0._goempty1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1")
	arg_1_0._goarrow1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1/#go_arrow1")
	arg_1_0._simageruanpan1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole1/#simage_ruanpan1")
	arg_1_0._btnhole2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole2")
	arg_1_0._btnunequip2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#btn_unequip2")
	arg_1_0._goempty2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2")
	arg_1_0._goarrow2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2/#go_arrow2")
	arg_1_0._simageruanpan2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole2/#simage_ruanpan2")
	arg_1_0._btnhole3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole3")
	arg_1_0._btnunequip3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#btn_unequip3")
	arg_1_0._goempty3 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3")
	arg_1_0._goarrow3 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3/#go_arrow3")
	arg_1_0._simageruanpan3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_normal/bottom/#btn_hole3/#simage_ruanpan3")
	arg_1_0._scrollcollectiondesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_normal/#scroll_collectiondesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnhole1:AddClickListener(arg_2_0._btnhole1OnClick, arg_2_0)
	arg_2_0._btnunequip1:AddClickListener(arg_2_0._btnunequip1OnClick, arg_2_0)
	arg_2_0._btnhole2:AddClickListener(arg_2_0._btnhole2OnClick, arg_2_0)
	arg_2_0._btnunequip2:AddClickListener(arg_2_0._btnunequip2OnClick, arg_2_0)
	arg_2_0._btnhole3:AddClickListener(arg_2_0._btnhole3OnClick, arg_2_0)
	arg_2_0._btnunequip3:AddClickListener(arg_2_0._btnunequip3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnhole1:RemoveClickListener()
	arg_3_0._btnunequip1:RemoveClickListener()
	arg_3_0._btnhole2:RemoveClickListener()
	arg_3_0._btnunequip2:RemoveClickListener()
	arg_3_0._btnhole3:RemoveClickListener()
	arg_3_0._btnunequip3:RemoveClickListener()
end

function var_0_0._btnunequip1OnClick(arg_4_0)
	arg_4_0._holeMoList[1] = nil

	arg_4_0:_updateHoles()
	arg_4_0:_btnblockOnClick()
end

function var_0_0._btnunequip2OnClick(arg_5_0)
	arg_5_0._holeMoList[2] = nil

	arg_5_0:_updateHoles()
	arg_5_0:_btnblockOnClick()
end

function var_0_0._btnunequip3OnClick(arg_6_0)
	arg_6_0._holeMoList[3] = nil

	arg_6_0:_updateHoles()
	arg_6_0:_btnblockOnClick()
end

function var_0_0._btnblockOnClick(arg_7_0)
	if arg_7_0._clickHoleIndex then
		local var_7_0 = arg_7_0["_goarrow" .. arg_7_0._clickHoleIndex].transform

		transformhelper.setLocalScale(var_7_0, 1, 1, 1)
	end

	gohelper.setActive(arg_7_0._scrollviewGo, false)
	gohelper.setActive(arg_7_0._btnblock, false)

	arg_7_0._clickHoleIndex = nil
end

function var_0_0._btnhole1OnClick(arg_8_0)
	arg_8_0:_clickholeBtn(1)
end

function var_0_0._btnhole2OnClick(arg_9_0)
	arg_9_0:_clickholeBtn(2)
end

function var_0_0._btnhole3OnClick(arg_10_0)
	arg_10_0:_clickholeBtn(3)
end

function var_0_0._clickholeBtn(arg_11_0, arg_11_1)
	if arg_11_0._clickHoleIndex then
		arg_11_0:_btnblockOnClick()

		return
	end

	arg_11_0._clickHoleIndex = arg_11_1

	local var_11_0 = arg_11_0["_btnhole" .. arg_11_1]

	RougeFavoriteCollectionEnchantListModel.instance:initData(arg_11_0._holeMoList[arg_11_1])
	gohelper.addChild(var_11_0.gameObject, arg_11_0._scrollviewGo)
	gohelper.setActive(arg_11_0._scrollviewGo, true)
	gohelper.setActive(arg_11_0._btnblock, true)
	recthelper.setAnchor(arg_11_0._scrollviewGo.transform, -1, 374)

	local var_11_1 = arg_11_0["_goarrow" .. arg_11_1].transform

	transformhelper.setLocalScale(var_11_1, 1, -1, 1)

	arg_11_0._scrollview.verticalNormalizedPosition = 1
end

function var_0_0.getHoleMoList(arg_12_0)
	return arg_12_0._holeMoList
end

function var_0_0._editableInitView(arg_13_0)
	gohelper.setActive(arg_13_0._btnhole1, false)
	gohelper.setActive(arg_13_0._btnhole2, false)
	gohelper.setActive(arg_13_0._btnhole3, false)

	arg_13_0._holeMoList = {}
	arg_13_0._holdNum = 3
	arg_13_0._scrollview = gohelper.findChildScrollRect(arg_13_0.viewGO, "Right/#go_normal/bottom/scrollview")
	arg_13_0._scrollviewGo = arg_13_0._scrollview.gameObject
	arg_13_0._scrollAnchor = recthelper.getAnchor(arg_13_0._scrollviewGo.transform)

	arg_13_0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, arg_13_0._onClickCollectionListItem, arg_13_0, LuaEventSystem.High)
	arg_13_0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionDropItem, arg_13_0._onClickCollectionDropItem, arg_13_0)
end

function var_0_0._onClickCollectionDropItem(arg_14_0, arg_14_1)
	arg_14_0._holeMoList[arg_14_0._clickHoleIndex] = arg_14_1

	arg_14_0:_updateHoles()
	arg_14_0:_btnblockOnClick()
end

function var_0_0._updateHoles(arg_15_0, arg_15_1)
	for iter_15_0 = 1, arg_15_0._holdNum do
		local var_15_0 = arg_15_0["_simageruanpan" .. iter_15_0]
		local var_15_1 = arg_15_0._holeMoList[iter_15_0]
		local var_15_2 = var_15_1 ~= nil

		gohelper.setActive(var_15_0, var_15_2)
		gohelper.setActive(arg_15_0["_btnunequip" .. iter_15_0], var_15_2)
		gohelper.setActive(arg_15_0["_goempty" .. iter_15_0], not var_15_2)

		if var_15_2 then
			var_15_0:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_15_1.id))
		end
	end

	if not arg_15_1 then
		arg_15_0.viewContainer:getCollectionListView():_refreshSelectCollectionInfo()
	end
end

function var_0_0._onClickCollectionListItem(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onRefresh, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._onRefresh, arg_16_0, RougeEnum.CollectionListViewDelayTime)
end

function var_0_0._onRefresh(arg_17_0)
	recthelper.setHeight(arg_17_0._scrollcollectiondesc.transform, 372)

	local var_17_0 = RougeCollectionListModel.instance:getSelectedConfig()

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.id
	local var_17_2 = RougeCollectionConfig.instance:getCollectionCfg(var_17_1)

	if not var_17_2 then
		return
	end

	if var_17_2.holeNum > 0 then
		recthelper.setHeight(arg_17_0._scrollcollectiondesc.transform, 293)
	end

	for iter_17_0 = 1, arg_17_0._holdNum do
		arg_17_0._holeMoList[iter_17_0] = nil

		arg_17_0:_setHoleVisible(iter_17_0, iter_17_0 <= var_17_2.holeNum)
	end

	arg_17_0:_updateHoles(true)
end

function var_0_0._setHoleVisible(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0["_btnhole" .. arg_18_1]

	gohelper.setActive(var_18_0, arg_18_2)
end

function var_0_0.onClose(arg_19_0)
	gohelper.setActive(arg_19_0._scrollviewGo, false)
	gohelper.setActive(arg_19_0._btnblock, false)
end

function var_0_0.onDestroyView(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onRefresh, arg_20_0)
end

return var_0_0
