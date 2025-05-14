module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView", package.seeall)

local var_0_0 = class("MainSceneSkinMaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._gobannerContent = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent")
	arg_1_0._goroominfoItem = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerscroll")
	arg_1_0._gobuyContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent")
	arg_1_0._goblockInfoItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	arg_1_0._gopay = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay")
	arg_1_0._gopayitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "right/#go_source")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "right/#go_source/title/#txt_time")
	arg_1_0._scrolljump = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_source/#scroll_jump")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btninsightOnClick(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gojumpItem, false)
	gohelper.setActive(arg_6_0._gobuyContent, false)
	gohelper.setActive(arg_6_0._gosource, true)

	arg_6_0._jumpParentGo = gohelper.findChild(arg_6_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	arg_6_0.jumpItemGos = {}

	arg_6_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._canJump = arg_7_0.viewParam.canJump
	arg_7_0._config = ItemModel.instance:getItemConfig(arg_7_0.viewParam.type, arg_7_0.viewParam.id)
	arg_7_0._sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(arg_7_0.viewParam.id)

	arg_7_0:_cloneJumpItem()
end

function var_0_0._cloneJumpItem(arg_8_0)
	arg_8_0._scrolljump.verticalNormalizedPosition = 1

	local var_8_0 = {}

	if arg_8_0._config then
		var_8_0 = arg_8_0:_sourcesStrToTables(arg_8_0._config.sources)
	end

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = arg_8_0.jumpItemGos[iter_8_0]

		if not var_8_1 then
			local var_8_2 = iter_8_0 == 1 and arg_8_0._gojumpItem or gohelper.clone(arg_8_0._gojumpItem, arg_8_0._jumpParentGo, "item" .. iter_8_0)

			var_8_1 = arg_8_0:getUserDataTb_()
			var_8_1.go = var_8_2
			var_8_1.originText = gohelper.findChildText(var_8_2, "frame/txt_chapter")
			var_8_1.indexText = gohelper.findChildText(var_8_2, "frame/txt_name")
			var_8_1.jumpBtn = gohelper.findChildButtonWithAudio(var_8_2, "frame/btn_jump")
			var_8_1.jumpBgGO = gohelper.findChild(var_8_2, "frame/btn_jump/jumpbg")

			table.insert(arg_8_0.jumpItemGos, var_8_1)
			var_8_1.jumpBtn:AddClickListener(function(arg_9_0)
				if arg_9_0.cantJumpTips then
					GameFacade.showToastWithTableParam(arg_9_0.cantJumpTips, arg_9_0.cantJumpParam)
				elseif arg_9_0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					arg_8_0:checkViewOpenAndClose()
					GameFacade.jump(arg_9_0.jumpId, arg_8_0._onJumpFinish, arg_8_0, arg_8_0.viewParam.recordFarmItem)
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, var_8_1)
		end

		local var_8_3 = var_8_0[iter_8_0]

		var_8_1.canJump = arg_8_0._canJump
		var_8_1.jumpId = var_8_3.sourceId

		local var_8_4, var_8_5 = JumpConfig.instance:getJumpName(var_8_3.sourceId)

		var_8_1.originText.text = var_8_4 or ""
		var_8_1.indexText.text = var_8_5 or ""

		local var_8_6, var_8_7 = arg_8_0:_getCantJump(var_8_3)

		ZProj.UGUIHelper.SetGrayscale(var_8_1.jumpBgGO, var_8_6 ~= nil)

		var_8_1.cantJumpTips = var_8_6
		var_8_1.cantJumpParam = var_8_7

		gohelper.setActive(var_8_1.go, true)

		local var_8_8 = JumpController.instance:isOnlyShowJump(var_8_3.sourceId)

		gohelper.setActive(var_8_1.jumpBtn, not var_8_8)
	end

	gohelper.setActive(arg_8_0._gosource, #var_8_0 > 0)

	for iter_8_1 = #var_8_0 + 1, #arg_8_0.jumpItemGos do
		gohelper.setActive(arg_8_0.jumpItemGos[iter_8_1].go, false)
	end
end

function var_0_0._sourcesStrToTables(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if not string.nilorempty(arg_10_1) then
		local var_10_1 = string.split(arg_10_1, "|")

		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			local var_10_2 = string.splitToNumber(iter_10_1, "#")
			local var_10_3 = {
				sourceId = var_10_2[1],
				probability = var_10_2[2]
			}

			var_10_3.episodeId = JumpConfig.instance:getJumpEpisodeId(var_10_3.sourceId)

			if var_10_3.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_10_3.episodeId) then
				table.insert(var_10_0, var_10_3)
			end
		end
	end

	return var_10_0
end

function var_0_0._getCantJump(arg_11_0, arg_11_1)
	local var_11_0 = JumpController.instance:isJumpOpen(arg_11_1.sourceId)
	local var_11_1
	local var_11_2
	local var_11_3 = JumpConfig.instance:getJumpConfig(arg_11_1.sourceId)

	if not var_11_0 then
		var_11_1, var_11_2 = OpenHelper.getToastIdAndParam(var_11_3.openId)
	else
		var_11_1, var_11_2 = JumpController.instance:cantJump(var_11_3.param)
	end

	return var_11_1, var_11_2
end

var_0_0.NeedCloseView = {
	ViewName.PackageStoreGoodsView
}

function var_0_0.checkViewOpenAndClose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_0.NeedCloseView) do
		if ViewMgr.instance:isOpen(iter_12_1) then
			ViewMgr.instance:closeView(iter_12_1)
		end
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:_refreshUI()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refreshUI()
end

function var_0_0.onClose(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.jumpItemGos do
		arg_15_0.jumpItemGos[iter_15_0].jumpBtn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagebg1:UnLoadImage()
	arg_16_0._simagebg2:UnLoadImage()
end

return var_0_0
