file_dataout_im = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/dataOut_im_expected.dat'
file_dataout_re = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/dataOut_re_expected.dat'
file_validout = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/validOut_expected.dat'
file_dataout_im_delete = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/dataout/dataOut_im_expected_delete.dat'
file_dataout_re_delete = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/dataout/dataOut_re_expected_delete.dat'
def delete_lines(file_dataout,file_validout,file_dataout_delete):
    with open(file_dataout_delete, 'w') as f2:
        pass
    with open(file_dataout, 'r') as f1,open(file_validout, 'r') as f3:
        dataout_lines = f1.readlines()
        validout_lines =f3.readlines()
    with open(file_dataout_delete, 'a') as f2:
        for i in range(len(validout_lines)):
            if int(validout_lines[i].strip())==1:
                f2.write(dataout_lines[i].strip()+'\n')
        print("complete!")
delete_lines(file_dataout_im,file_validout,file_dataout_im_delete)
delete_lines(file_dataout_re,file_validout,file_dataout_re_delete)