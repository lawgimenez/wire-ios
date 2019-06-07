
// Wire
// Copyright (C) 2019 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension ConversationInputBarViewController: TextViewProtocol {
    func textView(_ textView: UITextView, hasImageToPaste image: MediaAsset) {
        let confirmImageViewController = ConfirmAssetViewController()
        confirmImageViewController.image = image
        confirmImageViewController.previewTitle = conversation.displayName.uppercasedWithCurrentLocale


        confirmImageViewController.onConfirm = {[weak self] editedImage in
            self?.dismiss(animated: false)

            let finalImage: MediaAsset
            if let editedImage = editedImage {
                finalImage = editedImage
            } else {
                finalImage = image
            }

            self?.postImage(finalImage)
        }

        confirmImageViewController.onCancel = { [weak self] in
            self?.dismiss(animated: false)
        }

        present(confirmImageViewController, animated: false)

    }

    func textView(_ textView: UITextView, firstResponderChanged resigned: NSNumber) {
        updateAccessoryViews()
        updateNewButtonTitleLabel()
    }
}