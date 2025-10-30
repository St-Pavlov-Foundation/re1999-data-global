module("modules.logic.commandstation.view.CommandStationPaperGetView", package.seeall)

local var_0_0 = class("CommandStationPaperGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageDisk = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_Disk")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_Descr")
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_tangren_fei)
	arg_3_0._imageDisk:LoadImage(ResUrl.getCommandStationPaperIcon(arg_3_0.viewParam.paperCo.diskIcon))

	arg_3_0._txtDesc.text = arg_3_0.viewParam.paperCo.diskText
end

return var_0_0
