function varargout = Initial_Values(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Initial_Values_OpeningFcn, ...
                   'gui_OutputFcn',  @Initial_Values_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Initial_Values_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
movegui(hObject,'center');
guidata(hObject, handles);

function varargout = Initial_Values_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function cmd_default_Callback(hObject, eventdata, handles)

%{
set(handles.thresh,'String','20');
set(handles.theta_angle,'String','22.5');
set(handles.num_images,'String','24');
set(handles.difference,'String','25');
set(handles.radius,'String','15');

set(handles.crop_x,'String','250');
set(handles.crop_y,'String','0');
set(handles.crop_width,'String','250');
set(handles.crop_height,'String','500');
set(handles.view_x,'String','275');
set(handles.view_y,'String','275');
set(handles.view_z,'String','550');
%}

switch get(handles.fname,'String')
    case 'ideal'
        set(handles.fname,'String','ideal');
        set(handles.thresh,'String','20');
        set(handles.theta_angle,'String','22.5');
        set(handles.num_images,'String','16');
        set(handles.difference,'String','10');
        set(handles.radius,'String','8');

        set(handles.crop_x,'String','105');
        set(handles.crop_y,'String','0');
        set(handles.crop_width,'String','105');
        set(handles.crop_height,'String','213');
        set(handles.view_x,'String','100');
        set(handles.view_y,'String','100');
        set(handles.view_z,'String','220');
    case 'vaseline'
        set(handles.fname,'String','vaseline');
        set(handles.thresh,'String','20');
        set(handles.theta_angle,'String','22.5');
        set(handles.num_images,'String','32');
        set(handles.difference,'String','30');
        set(handles.radius,'String','20 25 26 27 28 29 30 31 32 33 34 35');

        set(handles.crop_x,'String','720');
        set(handles.crop_y,'String','900');
        set(handles.crop_width,'String','100');
        set(handles.crop_height,'String','650');
        set(handles.view_x,'String','400');
        set(handles.view_y,'String','400');
        set(handles.view_z,'String','700');
    case 'dermicool'
        set(handles.fname,'String','dermicool');
        set(handles.thresh,'String','45');
        set(handles.theta_angle,'String','22.5');
        set(handles.num_images,'String','32');
        set(handles.difference,'String','25');
        set(handles.radius,'String','20 21 22 26 29 31');
        
        set(handles.crop_x,'String','1620');
        set(handles.crop_y,'String','420');
        set(handles.crop_width,'String','80');
        set(handles.crop_height,'String','560');
        set(handles.view_x,'String','400');
        set(handles.view_y,'String','400');
        set(handles.view_z,'String','700');
    case 'powder'
        set(handles.fname,'String','powder');
        set(handles.thresh,'String','30');
        set(handles.theta_angle,'String','22.5');
        set(handles.num_images,'String','32');
        set(handles.difference,'String','10');
        set(handles.radius,'String','7');

        set(handles.crop_x,'String','1650');
        set(handles.crop_y,'String','150');
        set(handles.crop_width,'String','100');
        set(handles.crop_height,'String','500');
        set(handles.view_x,'String','200');
        set(handles.view_y,'String','300');
        set(handles.view_z,'String','600');
    otherwise
        fprintf('folder not found');
end
        
%{
set(handles.thresh,'String','25');
set(handles.theta_angle,'String','22.5');
set(handles.num_images,'String','32');
set(handles.difference,'String','20');
set(handles.radius,'String','15');

set(handles.crop_x,'String','1550');
set(handles.crop_y,'String','250');
set(handles.crop_width,'String','200');
set(handles.crop_height,'String','600');
set(handles.view_x,'String','600');
set(handles.view_y,'String','600');
set(handles.view_z,'String','800');
%}

function cmd_clear_Callback(hObject, eventdata, handles)

set(handles.thresh,'String','');
set(handles.theta_angle,'String','');
set(handles.num_images,'String','');
set(handles.difference,'String','');
set(handles.radius,'String','');

set(handles.crop_x,'String','');
set(handles.crop_y,'String','');
set(handles.crop_width,'String','');
set(handles.crop_height,'String','');
set(handles.view_x,'String','');
set(handles.view_y,'String','');
set(handles.view_z,'String','');

function cmd_save_Callback(hObject, eventdata, handles)

fol_name=get(handles.fname,'String');
threshold=str2double(get(handles.thresh,'String'));
theta=degtorad(str2double(get(handles.theta_angle,'String')));
num=str2double(get(handles.num_images,'String'));
rp=str2double(regexp(get(handles.radius,'String'),' ','split'));
diff=str2double(get(handles.difference,'String'));
c1=str2double(get(handles.crop_x,'String'));
c2=str2double(get(handles.crop_y,'String'));
w=str2double(get(handles.crop_width,'String'));
h=str2double(get(handles.crop_height,'String'));
x1=str2double(get(handles.view_x,'String'));
y1=str2double(get(handles.view_y,'String'));
z1=str2double(get(handles.view_z,'String'));

save('workspace1.mat');
close;
%pp;

function crop_x_Callback(hObject, eventdata, handles)

function crop_x_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function num_images_Callback(hObject, eventdata, handles)

function num_images_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function view_x_Callback(hObject, eventdata, handles)

function view_x_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function view_y_Callback(hObject, eventdata, handles)

function view_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function view_z_Callback(hObject, eventdata, handles)

function view_z_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function crop_height_Callback(hObject, eventdata, handles)

function crop_height_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function crop_width_Callback(hObject, eventdata, handles)

function crop_width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function crop_y_Callback(hObject, eventdata, handles)

function crop_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta_angle_Callback(hObject, eventdata, handles)

function theta_angle_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function difference_Callback(hObject, eventdata, handles)

function difference_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radius_Callback(hObject, eventdata, handles)

function radius_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function thresh_Callback(hObject, eventdata, handles)

function thresh_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fname_Callback(hObject, eventdata, handles)
cmd_default_Callback(hObject, eventdata, handles)

function fname_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
