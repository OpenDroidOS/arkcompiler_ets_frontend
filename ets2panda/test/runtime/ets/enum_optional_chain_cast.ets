/*
 * Copyright (c) 2026 OpenDroidOS
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

enum IconType { NONE, HEAD, LARGE }
enum Direction { ROW, COLUMN }

class Content {
    iconStyle: IconType = IconType.LARGE;
}

class Item {
    scale: double = 2.0;
    content: Content | undefined = new Content();

    direction(): Direction {
        if (this.scale >= 1.5 && this.content?.iconStyle &&
            (this.content?.iconStyle as IconType) > IconType.HEAD) {
            return Direction.COLUMN;
        }
        return Direction.ROW;
    }
}

function main(): void {
    let item = new Item();
    arktest.assertEQ(item.direction(), Direction.COLUMN);
    item.scale = 1.0;
    arktest.assertEQ(item.direction(), Direction.ROW);
    item.scale = 2.0;
    item.content!.iconStyle = IconType.NONE;
    arktest.assertEQ(item.direction(), Direction.ROW);
    item.content!.iconStyle = IconType.HEAD;
    arktest.assertEQ(item.direction(), Direction.ROW);
    item.content = undefined;
    arktest.assertEQ(item.direction(), Direction.ROW);
}
