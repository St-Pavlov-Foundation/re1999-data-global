module("modules.logic.battlepass.view.BpEnterView", package.seeall)

local var_0_0 = class("BpEnterView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagecover = gohelper.findChildSingleImage(arg_1_0.viewGO, "cover/#simage_cover")
	arg_1_0._transName = gohelper.findChildComponent(arg_1_0.viewGO, "cover/skinname", typeof(UnityEngine.Transform))
	arg_1_0._txtenname = gohelper.findChildText(arg_1_0.viewGO, "cover/skinname/name/#txt_enname")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "cover/skinname/#btn_detail")
	arg_1_0._simagedetail = gohelper.findChildSingleImage(arg_1_0.viewGO, "cover/skinname/#btn_detail")
	arg_1_0._headicon = gohelper.findChild(arg_1_0.viewGO, "stamp/icon")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_enter", AudioEnum.UI.play_ui_role_pieces_open)
	arg_1_0._txthead = gohelper.findChildTextMesh(arg_1_0.viewGO, "stamp/txt")
	arg_1_0._txtheadname = gohelper.findChildTextMesh(arg_1_0.viewGO, "stamp/name")
	arg_1_0._addReward = gohelper.findChild(arg_1_0.viewGO, "#go_addreward")
	arg_1_0._gostyle1 = gohelper.findChild(arg_1_0.viewGO, "#go_style1")
	arg_1_0._gostyle2 = gohelper.findChild(arg_1_0.viewGO, "#go_style2")
	arg_1_0._gostyle3 = gohelper.findChild(arg_1_0.viewGO, "#go_style3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)

	local var_4_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_4_0 then
		local var_4_1 = gohelper.findChildTextMesh(arg_4_0.viewGO, "cover/skinname")
		local var_4_2 = gohelper.findChildTextMesh(arg_4_0.viewGO, "cover/skinname/name")
		local var_4_3 = gohelper.findChildTextMesh(arg_4_0.viewGO, "cover/skinname/#txt_enname")

		var_4_1.text = var_4_0.bpSkinDesc
		var_4_2.text = var_4_0.bpSkinNametxt
		var_4_3.text = var_4_0.bpSkinEnNametxt
	end

	local var_4_4, var_4_5 = BpConfig.instance:getCurHeadItemName(BpModel.instance.id)

	arg_4_0._txtheadname.text = string.format("「%s」", var_4_4)

	IconMgr.instance:getCommonLiveHeadIcon(arg_4_0._headicon):setLiveHead(var_4_5)

	local var_4_6 = BpConfig.instance:getNewItems(BpModel.instance.id)
	local var_4_7 = #var_4_6

	if var_4_7 > 3 then
		logError("BP 新增道具数量错误" .. #var_4_6)
	elseif var_4_7 == 0 then
		gohelper.setActive(arg_4_0._addReward, false)
	else
		gohelper.setActive(arg_4_0._addReward, true)

		for iter_4_0 = 1, 3 do
			local var_4_8 = gohelper.findChild(arg_4_0._addReward, tostring(iter_4_0))

			if var_4_7 < iter_4_0 then
				gohelper.setActive(var_4_8, false)
			else
				local var_4_9 = var_4_6[iter_4_0]
				local var_4_10, var_4_11 = ItemModel.instance:getItemConfigAndIcon(var_4_9[1], var_4_9[2])

				gohelper.findChildSingleImage(var_4_8, "#simage_icon" .. iter_4_0):LoadImage(var_4_11)
			end
		end
	end
end

function var_0_0._btndetailOnClick(arg_5_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function var_0_0._btnenterOnClick(arg_6_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "714",
		[StatEnum.EventProperties.RecommendPageName] = "吼吼点唱机"
	})
	BpController.instance:openBattlePassView()
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagecover:UnLoadImage()
	arg_7_0._simagedetail:UnLoadImage()
end

return var_0_0
