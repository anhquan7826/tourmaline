import { useEffect, useRef, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Outlet, useLocation, useParams } from 'react-router-dom';

import Header from '../../components/Header';
import Sidebar from '../../components/Sidebar';
import Player from '../../components/Player';
import SidebarRight from '../../components/SidebarRight';
import * as actions from '../../store/actions';
import { crePlaylist } from '../../services/music';
import {
    CommentModal,
    CrePlaylistModal,
    DeleteModal,
    DeletePlaylistModal,
    EditSongModal,
    LoginModal,
} from '~/components/Modal';
import EditPlaylistModal from '~/components/Modal/EditPlaylistModal/EditPlaylistModal';
// import { CommentModal, CrePlaylistModal, DeleteModal, DeletePlaylistModal } from '../../components/Modal';

function DefaultLayout() {
    const [isShowSidebar, setIsShowSidebar] = useState(false);
    const [isOpenCrePlaylistModal, setIsOpenCrePlaylistModal] = useState(false);
    const [isOpenCommentModal, setIsOpenCommentModal] = useState(false);
    const [isOpenDeleteModal, setIsOpenDeleteModal] = useState(false);
    const [isOpenDeletePlaylistModal, setIsOpenDeletePlaylistModal] = useState(false);
    const [isOpenEditSongModal, setIsOpenEditSongModal] = useState(false);
    const [isOpenEditPlaylistModal, setIsOpenEditPlaylistModal] = useState(false);
    const [isOpenLogginModal, setIsOpenLogginModal] = useState(false);
    const { token } = useSelector((state) => state.auth);
    const [title, setTitle] = useState('');
    const { curSongId } = useSelector((state) => state.music);
    const dispatch = useDispatch();
    const { pathname } = useLocation();
    const { isLoggedIn } = useSelector((state) => state.auth);
    useEffect(() => {
        if (pathname != '/' && !isLoggedIn) {
            setIsOpenLogginModal((prev) => !prev);
        }
    }, [pathname]);
    useEffect(() => {
        dispatch(actions.setIsOpenCrePlaylistModal(setIsOpenCrePlaylistModal));
        dispatch(actions.setIsOpenCommentModal(setIsOpenCommentModal));
        dispatch(actions.setIsOpenDeleteModal(setIsOpenDeleteModal));
        dispatch(actions.setIsOpenDeletePlaylistModal(setIsOpenDeletePlaylistModal));
        dispatch(actions.setIsOpenEditSongModal(setIsOpenEditSongModal));
        dispatch(actions.setIsOpenEditPlaylistModal(setIsOpenEditPlaylistModal));
        dispatch(actions.setIsOpenLogginModal(setIsOpenLogginModal));
    }, []);

    const file = useRef();
    const onChange = (e) => {
        file.current = e.target.files[0];
    };
    const handleCreplaylist = async (e) => {
        const finalPayload = {
            name: title,
            cover: file.current,
        };
        const response = await crePlaylist(finalPayload, token);
        if (response.status) {
            setIsOpenCrePlaylistModal((prev) => !prev);
        }
    };
    return (
        // Làm effect sidebar cần bg-color cố định, sửa gradient nhé
        <div className="relative flex flex-col overflow-x-hidden bg-[var(--main-screen-bg)]">
            {isOpenCrePlaylistModal && <CrePlaylistModal />}
            {isOpenCommentModal && <CommentModal />}
            {isOpenDeleteModal && <DeleteModal />}
            {isOpenDeletePlaylistModal && <DeletePlaylistModal />}
            {isOpenEditSongModal && <EditSongModal />}
            {isOpenEditPlaylistModal && <EditPlaylistModal />}
            {isOpenLogginModal && <LoginModal />}
            <div className="flex h-screen w-screen">
                <div className="z-30 max-[1132px]:fixed">
                    <Sidebar />
                </div>
                <div className="max-w-[calc(100vw-var(--sidebar-width))] flex-1 max-[1132px]:ml-[var(--sidebar-width-small)] max-[1132px]:max-w-[calc(100vw-var(--sidebar-width-small))]">
                    {' '}
                    {/* limit width to swipe list playlist item */}
                    <Header />
                    <Outlet />
                </div>
                <div
                    className={`absolute right-0 top-0 bottom-0 w-[270px] ${
                        isShowSidebar ? 'animate-slide-left' : 'animate-slide-right'
                    }`}
                >
                    <SidebarRight />
                </div>
            </div>

            {curSongId != null && (
                <div className="absolute bottom-0 z-40 h-[var(--player-height)] w-full bg-[color:var(--player-bg)] py-3 px-4 [border-top:1px_solid_var(--player-border-color)]">
                    <Player setIsShowSidebar={setIsShowSidebar} />
                </div>
            )}
        </div>
    );
}

export default DefaultLayout;
